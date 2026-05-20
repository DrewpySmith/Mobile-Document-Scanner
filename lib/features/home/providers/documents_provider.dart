import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../../core/database/isar_service.dart';
import '../../../core/database/scan_document.dart';
import '../../../services/pdf_service.dart';
import '../../../services/ocr_service.dart';

// Provide global singleton of IsarService
final isarServiceProvider = Provider<IsarService>((ref) {
  return IsarService();
});

// Provide a global singleton of PdfService
final pdfServiceProvider = Provider<PdfService>((ref) {
  return PdfService();
});

// Provide a global singleton of OcrService
final ocrServiceProvider = Provider<OcrService>((ref) {
  return OcrService();
});

// Holds current reactive search term
final searchQueryProvider = StateProvider<String>((ref) => '');

// Holds current active sorting criteria ('newest', 'oldest', 'title_asc', 'title_desc')
final documentSortProvider = StateProvider<String>((ref) => 'newest');

// Main reactive controller managing Documents database state
class DocumentsNotifier extends AsyncNotifier<List<ScanDocument>> {
  @override
  Future<List<ScanDocument>> build() async {
    final isarService = ref.watch(isarServiceProvider);
    return isarService.getAllDocuments();
  }

  /// Create and save a new scanned document. Concurrently processes OCR and builds the PDF.
  Future<void> createDocument({
    required String title,
    required List<String> pageImagePaths,
  }) async {
    state = const AsyncValue.loading();
    
    state = await AsyncValue.guard(() async {
      final pdfService = ref.read(pdfServiceProvider);
      final ocrService = ref.read(ocrServiceProvider);
      final isarService = ref.read(isarServiceProvider);

      // Execute PDF compiling and OCR text extraction concurrently!
      final results = await Future.wait([
        pdfService.generatePdf(
          imagePaths: pageImagePaths,
          baseFileName: title,
        ),
        ocrService.processMultiPage(pageImagePaths),
      ]);

      final pdfPath = results[0];
      final rawOcrText = results[1];

      final document = ScanDocument()
        ..title = title.isEmpty ? 'Untitled Scan' : title
        ..createdAt = DateTime.now()
        ..pdfPath = pdfPath
        ..pageImagePaths = pageImagePaths
        ..rawOcrText = rawOcrText;

      await isarService.saveDocument(document);
      
      // Re-fetch sorted lists
      return isarService.getAllDocuments();
    });
  }

  /// Update the title of an existing scan
  Future<void> updateDocumentTitle(int id, String newTitle) async {
    final isarService = ref.read(isarServiceProvider);
    final isar = await isarService.db;
    
    await isar.writeTxn(() async {
      final doc = await isar.scanDocuments.get(id);
      if (doc != null) {
        doc.title = newTitle;
        await isar.scanDocuments.put(doc);
      }
    });

    ref.invalidateSelf();
  }

  /// Cache translation text inside Isar
  Future<void> updateTranslation(int id, String translatedText, String langCode) async {
    final isarService = ref.read(isarServiceProvider);
    final isar = await isarService.db;
    
    await isar.writeTxn(() async {
      final doc = await isar.scanDocuments.get(id);
      if (doc != null) {
        doc.translatedText = translatedText;
        doc.translatedLanguage = langCode;
        await isar.scanDocuments.put(doc);
      }
    });

    ref.invalidateSelf();
  }

  /// Delete document and clean up local images and PDF file to free up cache space.
  Future<void> deleteDocument(int id) async {
    final isarService = ref.read(isarServiceProvider);
    final isar = await isarService.db;

    final doc = await isar.scanDocuments.get(id);
    if (doc != null) {
      // 1. Delete associated local PDF
      try {
        final pdfFile = File(doc.pdfPath);
        if (await pdfFile.exists()) {
          await pdfFile.delete();
        }
      } catch (_) {}

      // 2. Delete raw page image crops
      for (String imagePath in doc.pageImagePaths) {
        try {
          final imageFile = File(imagePath);
          if (await imageFile.exists()) {
            await imageFile.delete();
          }
        } catch (_) {}
      }

      // 3. Delete from Database
      await isarService.deleteDocument(id);
    }

    ref.invalidateSelf();
  }

  /// Wipe database entirely (Cache Cleanup)
  Future<void> wipeAllData() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final isarService = ref.read(isarServiceProvider);
      
      // Try to clean up all physical files first
      final docs = await isarService.getAllDocuments();
      for (var doc in docs) {
        try {
          final pdf = File(doc.pdfPath);
          if (await pdf.exists()) await pdf.delete();
          for (var img in doc.pageImagePaths) {
            final image = File(img);
            if (await image.exists()) await image.delete();
          }
        } catch (_) {}
      }

      await isarService.clearDatabase();
      return [];
    });
  }
}

// Global hook of the document list notifier state
final documentsProvider = AsyncNotifierProvider<DocumentsNotifier, List<ScanDocument>>(() {
  return DocumentsNotifier();
});

// Reactive provider that serves searched, sorted, and filtered documents to the UI
final filteredDocumentsProvider = Provider<AsyncValue<List<ScanDocument>>>((ref) {
  final docsAsync = ref.watch(documentsProvider);
  final searchQuery = ref.watch(searchQueryProvider).toLowerCase();
  final sortBy = ref.watch(documentSortProvider);

  return docsAsync.whenData((docs) {
    // 1. Apply Search query
    var filtered = docs.where((doc) {
      return doc.title.toLowerCase().contains(searchQuery) ||
          doc.rawOcrText.toLowerCase().contains(searchQuery) ||
          (doc.translatedText?.toLowerCase().contains(searchQuery) ?? false);
    }).toList();

    // 2. Apply Sorts
    if (sortBy == 'newest') {
      filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } else if (sortBy == 'oldest') {
      filtered.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    } else if (sortBy == 'title_asc') {
      filtered.sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
    } else if (sortBy == 'title_desc') {
      filtered.sort((a, b) => b.title.toLowerCase().compareTo(a.title.toLowerCase()));
    }

    return filtered;
  });
});
