import 'package:isar/isar.dart';

part 'scan_document.g.dart';

@collection
class ScanDocument {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value)
  late String title;

  late DateTime createdAt;

  late String pdfPath;

  // Paths of individual page images stored locally
  late List<String> pageImagePaths;

  // Core OCR extracted text
  late String rawOcrText;

  // Cached translation content and targeted language
  String? translatedText;
  String? translatedLanguage;

  // Getter for combined search index
  @Index(type: IndexType.value, caseSensitive: false)
  String get searchText => '$title $rawOcrText ${translatedText ?? ""}';
}
