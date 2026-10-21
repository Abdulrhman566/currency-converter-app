import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../models/exchange_model.dart';

class ApiService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://v6.exchangerate-api.com/v6/9a409377ea75f99001556ba1",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<ExchangeModel> fetchExchangeRates(String baseCode) async {
    try {
      final response = await dio.get("/latest/$baseCode");

      debugPrint('Exchange API Status: ${response.statusCode}');

      debugPrint('Exchange API Response: ${response.data}');

      if (response.statusCode != 200) {
        throw Exception(
          'Failed to load exchange rates: '
          '${response.statusCode}',
        );
      }

      if (response.data is! Map) {
        throw Exception('Invalid response format');
      }

      return ExchangeModel.fromJson(Map<String, dynamic>.from(response.data));
    } on DioException catch (e) {
      debugPrint('Dio Error Type: ${e.type}');

      debugPrint('Dio Error Message: ${e.message}');

      debugPrint('Dio Response: ${e.response?.data}');

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Connection timeout. Please try again.');
      }

      if (e.type == DioExceptionType.sendTimeout) {
        throw Exception('Request timeout. Please try again.');
      }

      if (e.type == DioExceptionType.connectionError) {
        throw Exception(
          'Connection error. Please check your internet connection.',
        );
      }

      if (e.type == DioExceptionType.badResponse) {
        throw Exception('Server error: ${e.response?.statusCode}');
      }

      throw Exception(e.message ?? 'Network error');
    } catch (e, stackTrace) {
      debugPrint('Exchange Parsing Error: $e');

      debugPrint('Stack Trace: $stackTrace');

      // Don't hide the real parsing error.
      rethrow;
    }
  }
}
