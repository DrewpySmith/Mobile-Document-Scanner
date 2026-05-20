import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

class PdfService {
  /// Compiles a list of local image paths into a single structured, high-resolution PDF document.
  /// Standardizes output using standard A4 page formatting and centers content with scaling.
  Future<String> generatePdf({
    required List<String> imagePaths,
    required String baseFileName,
  }) async {
    if (imagePaths.isEmpty) {
      throw Exception('Cannot generate PDF from an empty list of scan pages.');
    }

    final pdf = pw.Document();

    for (String path in imagePaths) {
      final imageFile = File(path);
      if (!await imageFile.exists()) {
        continue;
      }

      final imageBytes = await imageFile.readAsBytes();
      final pdfImage = pw.MemoryImage(imageBytes);

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(12), // Elegant margin around pages
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Image(
                pdfImage,
                fit: pw.BoxFit.contain, // Scale to perfectly fit within printer boundary limits
              ),
            );
          },
        ),
      );
    }

    try {
      final directory = await getApplicationDocumentsDirectory();
      // Ensure file name is filesystem safe
      final safeName = baseFileName.replaceAll(RegExp(r'[^\w\s\-]'), '').trim().replaceAll(' ', '_');
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final pdfPath = '${directory.path}/${safeName}_$timestamp.pdf';
      
      final file = File(pdfPath);
      await file.writeAsBytes(await pdf.save());
      
      return pdfPath;
    } catch (e) {
      throw Exception('Failed to compile and write PDF: $e');
    }
  }

  /// Utility to clean up custom generated files in application directories if needed.
  Future<void> deletePdf(String path) async {
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }
}
