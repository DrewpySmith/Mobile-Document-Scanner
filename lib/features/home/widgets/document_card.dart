import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/database/scan_document.dart';
import '../providers/documents_provider.dart';

class DocumentCard extends ConsumerWidget {
  final ScanDocument doc;

  const DocumentCard({super.key, required this.doc});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasImages = doc.pageImagePaths.isNotEmpty;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GestureDetector(
      onTap: () => context.push('/document/${doc.id}'),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: 120,
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // 1. Scanned Image Thumbnail / Fallback Icon
              Hero(
                tag: 'doc-thumb-${doc.id}',
                child: Container(
                  width: 80,
                  height: 96,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                    border: Border.all(
                      color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
                      width: 1,
                    ),
                  ),
                  child: hasImages
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            File(doc.pageImagePaths.first),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => const Icon(
                              Icons.broken_image_rounded,
                              size: 28,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : const Icon(
                          Icons.picture_as_pdf_rounded,
                          size: 32,
                          color: Color(0xFF10B981),
                        ),
                ),
              ),
              const SizedBox(width: 16),

              // 2. Info details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      doc.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    
                    // Count of pages & creation timestamp
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${doc.pageImagePaths.length} ${doc.pageImagePaths.length == 1 ? "page" : "pages"}',
                            style: const TextStyle(
                              color: Color(0xFF10B981),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          DateFormat('MMM dd, yyyy · hh:mm a').format(doc.createdAt),
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontSize: 11,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    
                    // Extracted snippet preview
                    Text(
                      doc.rawOcrText.replaceAll('\n', ' '),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 12,
                          ),
                    ),
                  ],
                ),
              ),

              // 3. Quick Actions Menu Button
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert_rounded),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                onSelected: (value) {
                  if (value == 'delete') {
                    _confirmDelete(context, ref);
                  } else if (value == 'rename') {
                    _renameDialog(context, ref);
                  }
                },
                itemBuilder: (BuildContext context) => [
                  const PopupMenuItem(
                    value: 'rename',
                    child: Row(
                      children: [
                        Icon(Icons.edit_outlined, size: 20),
                        SizedBox(width: 12),
                        Text('Rename'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete_outline_rounded, color: Colors.red, size: 20),
                        SizedBox(width: 12),
                        Text('Delete', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Scanned Scan?'),
        content: const Text(
          'This will permanently delete this document and all its corresponding pages and PDF files. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(documentsProvider.notifier).deleteDocument(doc.id);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Document deleted successfully.')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _renameDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController(text: doc.title);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rename Scan'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Document Title',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                ref.read(documentsProvider.notifier).updateDocumentTitle(doc.id, controller.text.trim());
              }
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
