import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'scan_document.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [ScanDocumentSchema],
        directory: dir.path,
        inspector: true, // Local web browser DB inspector tool
      );
    }
    return Isar.getInstance()!;
  }

  // Helper getters for transactional operations
  Future<List<ScanDocument>> getAllDocuments() async {
    final isar = await db;
    return await isar.scanDocuments.where().sortByCreatedAtDesc().findAll();
  }

  Future<void> saveDocument(ScanDocument document) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.scanDocuments.put(document);
    });
  }

  Future<void> deleteDocument(int id) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.scanDocuments.delete(id);
    });
  }

  Future<void> clearDatabase() async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.clear();
    });
  }
}
