import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../services/ocr_service.dart';
import '../providers/documents_provider.dart';
import '../widgets/document_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  /// Triggers the native Document Scanner, runs OCR, compiles the PDF, and saves to database.
  Future<void> _startScanning(BuildContext context, WidgetRef ref) async {
    try {
      // 1. Launch Platform-Native Camera View (VisionKit / Google ML Scanner API)
      final images = await CunningDocumentScanner.getPictures();
      if (images == null || images.isEmpty) return;

      // 2. Open high-end blur processing overlay
      if (context.mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const _ScanningOverlay(),
        );
      }

      // 3. Persistence Save Transaction (Concurrently runs OCR and PDF compilation internally)
      final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
      final defaultTitle = 'Scan_$timestamp';

      await ref.read(documentsProvider.notifier).createDocument(
            title: defaultTitle,
            pageImagePaths: images,
          );

      // 5. Dismiss Overlay & Pop Success Toast
      if (context.mounted) {
        Navigator.pop(context); // Close loading overlay
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color(0xFF10B981),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            content: const Row(
              children: [
                Icon(Icons.check_circle_rounded, color: Colors.white),
                SizedBox(width: 12),
                Text('Document scanned and saved successfully!', style: TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context); // Close loading overlay
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Capture Failed'),
            content: Text(e.toString().replaceFirst('Exception: ', '')),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              )
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = TextEditingController(text: ref.read(searchQueryProvider));
    final docsAsync = ref.watch(filteredDocumentsProvider);
    final currentSort = ref.watch(documentSortProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ScanMind'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/settings'),
            tooltip: 'Settings',
          ),
        ],
      ),
      body: Column(
        children: [
          // 1. Custom Premium Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF131A26) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
                  width: 1,
                ),
              ),
              child: TextField(
                controller: searchController,
                onChanged: (value) => ref.read(searchQueryProvider.notifier).state = value,
                decoration: InputDecoration(
                  hintText: 'Search title, scans, or translations...',
                  prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF10B981)),
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded),
                          onPressed: () {
                            searchController.clear();
                            ref.read(searchQueryProvider.notifier).state = '';
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ),
          ),

          // 2. Category Sort Filter Pills
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _buildSortPill(ref, 'Newest', 'newest', currentSort),
                const SizedBox(width: 8),
                _buildSortPill(ref, 'Oldest', 'oldest', currentSort),
                const SizedBox(width: 8),
                _buildSortPill(ref, 'Title A-Z', 'title_asc', currentSort),
                const SizedBox(width: 8),
                _buildSortPill(ref, 'Title Z-A', 'title_desc', currentSort),
              ],
            ),
          ),

          // 3. Documents Stream List View
          Expanded(
            child: docsAsync.when(
              loading: () => const _SkeletonLoader(),
              error: (err, stack) => Center(
                child: Text('Failed to load database: $err'),
              ),
              data: (documents) {
                if (documents.isEmpty) {
                  return _buildEmptyState(context, ref);
                }
                return ListView.separated(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 90),
                  itemCount: documents.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final doc = documents[index];
                    return DocumentCard(doc: doc);
                  },
                );
              },
            ),
          ),
        ],
      ),
      
      // Floating Capture Action Button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _startScanning(context, ref),
        icon: const Icon(Icons.camera_rounded, size: 24),
        label: const Text(
          'NEW SCAN',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.1),
        ),
      ),
    );
  }

  Widget _buildSortPill(WidgetRef ref, String label, String key, String activeKey) {
    final isActive = key == activeKey;
    return ChoiceChip(
      label: Text(label),
      selected: isActive,
      onSelected: (selected) {
        if (selected) {
          ref.read(documentSortProvider.notifier).state = key;
        }
      },
      selectedColor: const Color(0xFF10B981).withOpacity(0.15),
      labelStyle: TextStyle(
        color: isActive ? const Color(0xFF10B981) : Colors.grey,
        fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
      ),
      side: BorderSide(
        color: isActive ? const Color(0xFF10B981) : Colors.grey.withOpacity(0.3),
        width: 1,
      ),
      showCheckmark: false,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }

  Widget _buildEmptyState(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF131A26) : const Color(0xFFF1F5F9),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.folder_open_rounded,
                size: 64,
                color: Color(0xFF10B981),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No Documents Found',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              'Your scanned documents will appear here. Tap the "New Scan" button to capture your first document page and extract text.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => _startScanning(context, ref),
              icon: const Icon(Icons.add_rounded),
              label: const Text('Scan Document'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF10B981),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Gorgeous Blur/Loading Scanning Overlay
class _ScanningOverlay extends StatelessWidget {
  const _ScanningOverlay();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.65),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(32),
          margin: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 30,
                offset: const Offset(0, 10),
              )
            ],
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 48,
                height: 48,
                child: CircularProgressIndicator(
                  strokeWidth: 4.0,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF10B981)),
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Processing Pages...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Google ML Kit is extracting text blocks & compiling PDF document...',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom modern skeleton placeholder list
class _SkeletonLoader extends StatelessWidget {
  const _SkeletonLoader();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: 4,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return Container(
          height: 120,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF131A26) : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
            ),
          ),
          child: Row(
            children: [
              // Image Box placeholder
              Container(
                width: 80,
                height: 96,
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 140,
                      height: 16,
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 80,
                      height: 12,
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      height: 12,
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
