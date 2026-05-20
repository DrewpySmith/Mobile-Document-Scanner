import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_client.dart';

// Provide global singleton of network client
final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient();
});

class TranslationState {
  final bool isLoading;
  final String? translatedText;
  final String? errorMessage;

  TranslationState({
    this.isLoading = false,
    this.translatedText,
    this.errorMessage,
  });

  TranslationState copyWith({
    bool? isLoading,
    String? translatedText,
    String? errorMessage,
  }) {
    return TranslationState(
      isLoading: isLoading ?? this.isLoading,
      translatedText: translatedText ?? this.translatedText,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class TranslationNotifier extends StateNotifier<TranslationState> {
  final DioClient _dioClient;

  TranslationNotifier(this._dioClient) : super(TranslationState());

  /// Triggers a translation call. Sets loading state and catches any REST failures.
  Future<void> translate({
    required String text,
    required String sourceLang,
    required String targetLang,
  }) async {
    state = TranslationState(isLoading: true);
    try {
      final translation = await _dioClient.translateText(
        text: text,
        sourceLang: sourceLang,
        targetLang: targetLang,
      );
      state = TranslationState(translatedText: translation);
    } catch (e) {
      // Extract user-friendly message
      final cleanedMsg = e.toString().replaceFirst('Exception: ', '');
      state = TranslationState(errorMessage: cleanedMsg);
    }
  }

  /// Reset state to empty
  void clear() {
    state = TranslationState();
  }
}

// Auto-disposed translation provider to free memory when UI closes
final translationProvider = StateNotifierProvider.autoDispose<TranslationNotifier, TranslationState>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return TranslationNotifier(dioClient);
});
