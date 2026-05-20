import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:isar/isar.dart';
import '../../../core/database/scan_document.dart';
import '../../home/providers/documents_provider.dart';
import '../widgets/translation_dialog.dart';

class DocumentDetailScreen extends ConsumerStatefulWidget {
  final int documentId;

  const DocumentDetailScreen({super.key, required this.documentId});

  @override
  ConsumerState<DocumentDetailScreen> createState() => _DocumentDetailScreenState();
}

class _DocumentDetailScreenState extends ConsumerState<DocumentDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _ocrController;
  bool _isEditingOcr = false;
  bool _hasOcrLoaded = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _ocrController = TextEditingController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _ocrController.dispose();
    super.dispose();
  }

  /// Exports and shares the compiled PDF file using system sharing dialogue hooks
  Future<void> _sharePdf(ScanDocument doc) async {
    final file = File(doc.pdfPath);
    if (await file.exists()) {
      await Share.shareXFiles(
        [XFile(doc.pdfPath)],
        text: 'Sharing compiled PDF: ${doc.title}',
        subject: doc.title,
      );
    } else {
      // PDF file deleted or missing from cache - rebuild
      try {
        final pdfService = ref.read(pdfServiceProvider);
        final isarService = ref.read(isarServiceProvider);

        // Show dialog loader
        if (mounted) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(child: CircularProgressIndicator()),
          );
        }

        final newPdfPath = await pdfService.generatePdf(
          imagePaths: doc.pageImagePaths,
          baseFileName: doc.title,
        );

        // Update database reference
        final isar = await isarService.db;
        await isar.writeTxn(() async {
          doc.pdfPath = newPdfPath;
          await isar.scanDocuments.put(doc);
        });

        if (mounted) {
          Navigator.pop(context); // Close loader
          await Share.shareXFiles([XFile(newPdfPath)], subject: doc.title);
        }
      } catch (e) {
        if (mounted) {
          Navigator.pop(context); // Close loader
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to compile PDF: $e')),
          );
        }
      }
    }
  }

  /// Triggers save action for modified raw OCR texts
  Future<void> _saveOcrEdits(ScanDocument doc) async {
    final isarService = ref.read(isarServiceProvider);
    final isar = await isarService.db;

    await isar.writeTxn(() async {
      final freshDoc = await isar.scanDocuments.get(doc.id);
      if (freshDoc != null) {
        freshDoc.rawOcrText = _ocrController.text;
        await isar.scanDocuments.put(freshDoc);
      }
    });

    setState(() {
      _isEditingOcr = false;
    });
    
    // Invalidate state to trigger UI redraws
    ref.invalidate(documentsProvider);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Extracted text edits saved successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final docsAsync = ref.watch(documentsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return docsAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, stack) => Scaffold(body: Center(child: Text('Error loading scan details: $err'))),
      data: (docs) {
        // Safe check
        final doc = docs.firstWhere((d) => d.id == widget.documentId, orElse: () => ScanDocument());
        if (doc.id == Isar.autoIncrement) {
          // Document was deleted or does not exist, navigate back
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) context.pop();
          });
          return const Scaffold(body: SizedBox());
        }

        // Initialize OCR editor controller only once
        if (!_hasOcrLoaded) {
          _ocrController.text = doc.rawOcrText;
          _hasOcrLoaded = true;
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(doc.title),
            actions: [
              IconButton(
                icon: const Icon(Icons.share_rounded),
                onPressed: () => _sharePdf(doc),
                tooltip: 'Share PDF document',
              ),
              IconButton(
                icon: const Icon(Icons.translate_rounded),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => TranslationDialog(
                      documentId: doc.id,
                      textToTranslate: doc.rawOcrText,
                    ),
                  );
                },
                tooltip: 'Translate Document',
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'delete') {
                    ref.read(documentsProvider.notifier).deleteDocument(doc.id);
                    context.pop();
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'delete',
                    child: Text('Delete Document', style: TextStyle(color: Colors.red)),
                  ),
                ],
              )
            ],
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: const Color(0xFF10B981),
              labelColor: const Color(0xFF10B981),
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Tab(icon: Icon(Icons.photo_library_outlined), text: 'Pages'),
                Tab(icon: Icon(Icons.article_outlined), text: 'Extracted Text'),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              // PANEL 1: Scan Pages Carousel/Grid
              _buildPagesGrid(doc),

              // PANEL 2: Editable OCR & Translations text view
              _buildOcrPanel(doc, isDark),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPagesGrid(ScanDocument doc) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: doc.pageImagePaths.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (context, index) {
        final path = doc.pageImagePaths[index];
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.file(
                File(path),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Icon(Icons.broken_image, color: Colors.grey),
                ),
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.65),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Page ${index + 1}',
                    style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildOcrPanel(ScanDocument doc, bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Segment: OCR Text Edit Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'OCR Extracted Content',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF10B981)),
              ),
              if (_isEditingOcr)
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close_rounded, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          _ocrController.text = doc.rawOcrText;
                          _isEditingOcr = false;
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.check_rounded, color: Color(0xFF10B981)),
                      onPressed: () => _saveOcrEdits(doc),
                    ),
                  ],
                )
              else
                IconButton(
                  icon: const Icon(Icons.edit_outlined, color: Colors.grey),
                  onPressed: () => setState(() => _isEditingOcr = true),
                )
            ],
          ),
          const SizedBox(height: 8),

          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF131A26) : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
              ),
            ),
            child: _isEditingOcr
                ? TextField(
                    controller: _ocrController,
                    maxLines: null,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'No readable text in this document...',
                    ),
                    style: const TextStyle(fontSize: 14, height: 1.5),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectableText(
                        doc.rawOcrText,
                        style: const TextStyle(fontSize: 14, height: 1.5),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.copy_rounded, size: 20),
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: doc.rawOcrText));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Raw text copied to clipboard!')),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
          const SizedBox(height: 24),

          // Segment: Translation Cache Section
          if (doc.translatedText != null && doc.translatedText!.isNotEmpty) ...[
            Text(
              'Latest Translation (${doc.translatedLanguage})',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF0EA5E9)),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF131A26) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(
                    doc.translatedText!,
                    style: const TextStyle(fontSize: 14, height: 1.5),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.copy_rounded, size: 20),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: doc.translatedText!));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Translation copied to clipboard!')),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
