import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class OcrService {
  /// Processes a single image file on-device using ML Kit Latin script recognizer.
  /// Extracts and returns the parsed string block by block.
  Future<String> processImage(String filePath) async {
    final file = File(filePath);
    if (!await file.exists()) {
      throw Exception('Input scan image file does not exist at path: $filePath');
    }

    final inputImage = InputImage.fromFile(file);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    try {
      final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
      
      // Keep structural spaces between recognized text blocks
      final StringBuffer buffer = StringBuffer();
      for (TextBlock block in recognizedText.blocks) {
        for (TextLine line in block.lines) {
          buffer.writeln(line.text);
        }
        buffer.writeln(); // Blank line between paragraphs/blocks
      }

      final resultText = buffer.toString().trim();
      return resultText.isEmpty ? 'No readable text was found in this document page.' : resultText;
    } catch (e) {
      throw Exception('Failed to perform local OCR: $e');
    } finally {
      // Free the native resources associated with the recognizer
      await textRecognizer.close();
    }
  }

  /// Processes a single image file on-device using a shared TextRecognizer instance.
  Future<String> _processImageWithRecognizer(TextRecognizer textRecognizer, String filePath) async {
    final file = File(filePath);
    if (!await file.exists()) {
      throw Exception('Input scan image file does not exist at path: $filePath');
    }

    final inputImage = InputImage.fromFile(file);

    try {
      final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
      
      // Keep structural spaces between recognized text blocks
      final StringBuffer buffer = StringBuffer();
      for (TextBlock block in recognizedText.blocks) {
        for (TextLine line in block.lines) {
          buffer.writeln(line.text);
        }
        buffer.writeln(); // Blank line between paragraphs/blocks
      }

      final resultText = buffer.toString().trim();
      return resultText.isEmpty ? 'No readable text was found in this document page.' : resultText;
    } catch (e) {
      throw Exception('Failed to perform local OCR: $e');
    }
  }

  /// Processes multiple images in sequence and joins their text with clean page-break delimiters.
  /// Instantiates a single TextRecognizer and reuses it for all pages to avoid native initialization overhead.
  Future<String> processMultiPage(List<String> filePaths) async {
    if (filePaths.isEmpty) return '';
    
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final StringBuffer fullTextBuffer = StringBuffer();
    
    try {
      for (int i = 0; i < filePaths.length; i++) {
        if (i > 0) {
          fullTextBuffer.writeln('\n--- Page ${i + 1} ---\n');
        }
        final pageText = await _processImageWithRecognizer(textRecognizer, filePaths[i]);
        fullTextBuffer.writeln(pageText);
      }
    } finally {
      await textRecognizer.close();
    }
    
    return fullTextBuffer.toString().trim();
  }
}
