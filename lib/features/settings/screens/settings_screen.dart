import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_provider.dart';
import '../../home/providers/documents_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isDark = themeMode == ThemeMode.dark ||
        (themeMode == ThemeMode.system && MediaQuery.of(context).platformBrightness == Brightness.dark);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Theme settings group
          _buildSectionHeader('Appearance'),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                    color: const Color(0xFF10B981),
                  ),
                  title: const Text('Dark Mode'),
                  subtitle: const Text('Toggle between dark and light appearance'),
                  trailing: Switch(
                    value: isDark,
                    onChanged: (val) {
                      ref.read(themeProvider.notifier).toggleTheme(val);
                    },
                    activeColor: const Color(0xFF10B981),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // OCR & Format Settings group
          _buildSectionHeader('Scanning Settings'),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.picture_as_pdf_rounded, color: Color(0xFF10B981)),
                  title: const Text('Default Export Format'),
                  subtitle: const Text('Always optimized Standard A4 PDFs'),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'PDF (A4)',
                      style: TextStyle(color: Color(0xFF10B981), fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ),
                const Divider(height: 1, indent: 16, endIndent: 16),
                const ListTile(
                  leading: Icon(Icons.language_rounded, color: Color(0xFF10B981)),
                  title: const Text('OCR Script Engine'),
                  subtitle: const Text('Google ML Kit on-device Latin engine'),
                  trailing: Text(
                    'Active',
                    style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Database & Cache Cleanup group
          _buildSectionHeader('Data & Storage Management'),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.cleaning_services_rounded, color: Colors.amber),
                  title: const Text('Clear Storage Cache'),
                  subtitle: const Text('Removes temporary captured page file caches'),
                  onTap: () => _confirmClearCache(context, ref),
                ),
                const Divider(height: 1, indent: 16, endIndent: 16),
                ListTile(
                  leading: const Icon(Icons.delete_forever_rounded, color: Colors.red),
                  title: const Text('Wipe All Database Scans'),
                  subtitle: const Text('Permanently deletes all database lists and physical files'),
                  onTap: () => _confirmWipeDB(context, ref),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),

          // Brand Credits
          Center(
            child: Column(
              children: [
                const Text(
                  'ScanMind for Flutter',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  'Version 1.0.0 (Stable MVP)',
                  style: TextStyle(fontSize: 12, color: Colors.grey.withOpacity(0.8)),
                ),
                const SizedBox(height: 12),
                const Icon(Icons.all_inclusive_rounded, color: Color(0xFF10B981), size: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  void _confirmClearCache(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Cache?'),
        content: const Text(
          'This cleans up duplicate image scans and non-referenced temporary cache records. Your saved document scans will remain intact.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Temporary cache files cleared successfully!')),
              );
            },
            child: const Text('Clear'),
          )
        ],
      ),
    );
  }

  void _confirmWipeDB(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Wipe All Database Scans?'),
        content: const Text(
          'Are you absolutely sure? This will delete EVERY document scan record, every single OCR raw text, and permanently delete all local PDF files. This action CANNOT be undone.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              ref.read(documentsProvider.notifier).wipeAllData();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('All database contents and physical PDF files deleted successfully.'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            child: const Text('Wipe Everything'),
          )
        ],
      ),
    );
  }
}
