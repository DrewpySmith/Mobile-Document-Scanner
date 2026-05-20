import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.mymemory.translated.net',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        'Accept': 'application/json',
      },
    ),
  );

  Dio get dio => _dio;

  /// Translates text using the MyMemory Free API
  /// [text] The text content to translate
  /// [sourceLang] The ISO 639-1 source language code (e.g. 'en' or 'auto' for autodetect)
  /// [targetLang] The ISO 639-1 target language code (e.g. 'es', 'fr')
  Future<String> translateText({
    required String text,
    required String sourceLang,
    required String targetLang,
  }) async {
    try {
      final response = await _dio.get(
        '/get',
        queryParameters: {
          'q': text,
          'langpair': '$sourceLang|$targetLang',
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data != null && data['responseData'] != null) {
          final translated = data['responseData']['translatedText'] as String;
          return translated;
        }
      }
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: 'Failed to parse translation response.',
      );
    } on DioException catch (e) {
      String errorMessage = 'Network error occurred during translation.';
      if (e.type == DioExceptionType.connectionTimeout) {
        errorMessage = 'Connection timeout. Check your internet connection.';
      } else if (e.response?.statusCode == 429) {
        errorMessage = 'Free quota rate limit reached. Please try again later.';
      } else if (e.message != null) {
        errorMessage = e.message!;
      }
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('An unexpected translation error occurred: $e');
    }
  }
}
