import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../constants/app_constants.dart';

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

  ApiService(this._dio);

  // GET request
  Future<Map<String, dynamic>> get(String endpoint, {Map<String, String>? queryParameters}) async {
    try {
      final response = await _dio.get('${AppConstants.apiBaseUrl}$endpoint', queryParameters: queryParameters);
      
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  // POST request
  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('${AppConstants.apiBaseUrl}$endpoint', data: data);
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception('Failed to create data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  // PUT request
  Future<Map<String, dynamic>> put(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put('${AppConstants.apiBaseUrl}$endpoint', data: data);
      
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to update data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  // DELETE request
  Future<Map<String, dynamic>> delete(String endpoint) async {
    try {
      final response = await _dio.delete('${AppConstants.apiBaseUrl}$endpoint');
      
      if (response.statusCode == 200 || response.statusCode == 204) {
        return response.data;
      } else {
        throw Exception('Failed to delete data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  // Upload file
  Future<String> uploadFile(String endpoint, String filePath) async {
    try {
      final file = await MultipartFile.fromFile(filePath);
      final formData = FormData.fromMap({
        'file': file,
      });
      
      final response = await _dio.post('${AppConstants.apiBaseUrl}$endpoint', data: formData);
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data['fileUrl'];
      } else {
        throw Exception('Failed to upload file: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  // Download file
  Future<void> downloadFile(String url, String savePath) async {
    try {
      final response = await _dio.download(url, savePath);
      
      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception('Failed to download file: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  // Check connectivity
  Future<bool> isConnected() async {
    try {
      final response = await _dio.get('${AppConstants.apiBaseUrl}/health');
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  // Set authentication token
  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  // Clear authentication token
  void clearAuthToken() {
    _dio.options.headers.remove('Authorization');
  }

  // Handle API errors
  String getErrorMessage(int statusCode, dynamic errorData) {
    switch (statusCode) {
      case 400:
        return 'Bad request: ${errorData['message'] ?? 'Invalid data'}';
      case 401:
        return 'Unauthorized: Please login again';
      case 403:
        return 'Forbidden: You don\'t have permission';
      case 404:
        return 'Not found: The requested resource was not found';
      case 500:
        return 'Server error: Please try again later';
      default:
        return 'Something went wrong: Please try again';
    }
  }

  // Retry mechanism
  Future<T> retryOperation<T>(
    Future<T> Function() operation,
    {int maxRetries = 3,
    Duration delay = const Duration(seconds: 1),
  }) async {
    for (int i = 0; i < maxRetries; i++) {
      try {
        return await operation();
      } catch (e) {
        if (i == maxRetries - 1) {
          rethrow;
        } else {
          await Future.delayed(delay);
        }
      }
    }
    
    throw Exception('Operation failed after $maxRetries retries');
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
