import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/translation_provider.dart';
import '../../home/providers/documents_provider.dart';

class TranslationDialog extends ConsumerStatefulWidget {
  final int documentId;
  final String textToTranslate;

  const TranslationDialog({
    super.key,
    required this.documentId,
    required this.textToTranslate,
  });

  @override
  ConsumerState<TranslationDialog> createState() => _TranslationDialogState();
}

class _TranslationDialogState extends ConsumerState<TranslationDialog> {
  String _sourceLang = 'en';
  String _targetLang = 'es';

  final Map<String, String> _languages = {
    'en': 'English',
    'es': 'Spanish',
    'fr': 'French',
    'tl': 'Filipino',
    'ja': 'Japanese',
  };

  @override
  Widget build(BuildContext context) {
    final translationState = ref.watch(translationProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Listen to translation changes to save to database automatically
    ref.listen(translationProvider, (previous, next) {
      if (next.translatedText != null && next.translatedText!.isNotEmpty) {
        ref.read(documentsProvider.notifier).updateTranslation(
              widget.documentId,
              next.translatedText!,
              _languages[_targetLang]!,
            );
      }
    });

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          Text(
            'Translate Document',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 20),

          // Language Pickers Row
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('From', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF131A26) : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _sourceLang,
                          isExpanded: true,
                          items: _languages.entries.map((e) {
                            return DropdownMenuItem(value: e.key, child: Text(e.value));
                          }).toList(),
                          onChanged: (val) {
                            if (val != null) setState(() => _sourceLang = val);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Icon(Icons.swap_horiz_rounded, color: Color(0xFF10B981)),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('To', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF131A26) : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _targetLang,
                          isExpanded: true,
                          items: _languages.entries.map((e) {
                            return DropdownMenuItem(value: e.key, child: Text(e.value));
                          }).toList(),
                          onChanged: (val) {
                            if (val != null) setState(() => _targetLang = val);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Translation Result Box or Action
          if (translationState.isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40.0),
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF10B981)),
                ),
              ),
            )
          else if (translationState.errorMessage != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                children: [
                  const Icon(Icons.error_outline_rounded, color: Colors.red, size: 36),
                  const SizedBox(height: 12),
                  Text(
                    translationState.errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _triggerTranslation,
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            )
          else if (translationState.translatedText != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Translation Result', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF10B981))),
                const SizedBox(height: 8),
                Container(
                  constraints: const BoxConstraints(maxHeight: 180),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF090D16) : const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: SelectableText(
                      translationState.translatedText!,
                      style: const TextStyle(fontSize: 14, height: 1.5),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: translationState.translatedText!));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Translation copied to clipboard!')),
                          );
                        },
                        icon: const Icon(Icons.copy_rounded, size: 18),
                        label: const Text('Copy Translation'),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          else
            const SizedBox(height: 8),

          const SizedBox(height: 16),
          
          // Primary action buttons
          if (!translationState.isLoading && translationState.translatedText == null)
            ElevatedButton.icon(
              onPressed: _triggerTranslation,
              icon: const Icon(Icons.translate_rounded),
              label: const Text('Translate Now'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF10B981),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  void _triggerTranslation() {
    if (widget.textToTranslate.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No extracted text found to translate.')),
      );
      return;
    }
    
    ref.read(translationProvider.notifier).translate(
          text: widget.textToTranslate,
          sourceLang: _sourceLang,
          targetLang: _targetLang,
        );
  }
}
