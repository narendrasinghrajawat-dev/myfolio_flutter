import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

enum Environment {
  development,
  production,
}

class AppConfig {
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'http://localhost:3000/api',
  );

  static const Environment environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'development',
  ) == 'production' 
      ? Environment.production 
      : Environment.development;

  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  static bool get isDevelopment => environment == Environment.development;
  static bool get isProduction => environment == Environment.production;
}

class ApiService {
  final Dio _dio;
  
  ApiService(this._dio) : super();

  // Generic GET request
  Future<Map<String, dynamic>> get(String endpoint, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: queryParameters);
      return response.data;
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Generic POST request
  Future<Map<String, dynamic>> post(String endpoint, {dynamic data}) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response.data;
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Generic PUT request
  Future<Map<String, dynamic>> put(String endpoint, {dynamic data}) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return response.data;
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Generic DELETE request
  Future<Map<String, dynamic>> delete(String endpoint) async {
    try {
      final response = await _dio.delete(endpoint);
      return response.data;
    } catch (e) {
      throw _handleError(e);
    }
  }

  // File upload
  Future<Map<String, dynamic>> uploadFile(String endpoint, String filePath, {String? fieldName}) async {
    try {
      final file = MultipartFile.fromFile(
        filePath,
        filename: filePath.split('/').last,
      );
      
      final formData = FormData.fromMap({
        fieldName ?? 'file': file,
      });
      
      final response = await _dio.post(endpoint, data: formData);
      return response.data;
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Error handling
  Exception _handleError(dynamic error) {
    if (error is DioException) {
      final dioError = error as DioException;
      
      switch (dioError.type) {
        case DioExceptionType.connectionTimeout:
          return Exception('Connection timeout. Please check your internet connection.');
        case DioExceptionType.receiveTimeout:
          return Exception('Request timeout. Please try again.');
        case DioExceptionType.badResponse:
          return Exception('Server error: ${dioError.message}');
        case DioExceptionType.cancel:
          return Exception('Request was cancelled.');
        case DioExceptionType.unknown:
          return Exception('Unknown error occurred: ${dioError.message}');
        default:
          return Exception('Network error: ${dioError.message}');
      }
    }
    
    return Exception('An unexpected error occurred: $error');
  }
}

// Providers
final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(
    baseUrl: AppConfig.baseUrl,
    connectTimeout: AppConfig.connectTimeout,
    receiveTimeout: AppConfig.receiveTimeout,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));
});

final apiServiceProvider = Provider<ApiService>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiService(dio);
});
