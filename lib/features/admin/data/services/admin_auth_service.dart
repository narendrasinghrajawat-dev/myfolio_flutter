import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/network_service.dart';
import '../../../../core/exceptions/app_exceptions.dart';

/// Admin Auth API service for making admin authentication-related API calls
class AdminAuthService {
  final NetworkService _networkService;

  AdminAuthService(this._networkService);

  /// Admin login with email and password
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _networkService.post<Map<String, dynamic>>(
        '/admin/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      return response as Map<String, dynamic>;
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  /// Admin logout
  Future<void> logout() async {
    try {
      await _networkService.post<void>(
        '/admin/auth/logout',
      );
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  /// Get current admin profile
  Future<Map<String, dynamic>> getCurrentAdmin() async {
    try {
      final response = await _networkService.get<Map<String, dynamic>>(
        '/admin/auth/me',
      );
      return response as Map<String, dynamic>;
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  Exception _handleAuthError(dynamic error) {
    if (error is AppException) {
      return error;
    }
    return NetworkException('Something went wrong');
  }
}

/// Provider for AdminAuthService
final adminAuthProvider = Provider<AdminAuthService>((ref) {
  final networkService = ref.watch(networkServiceProvider);
  return AdminAuthService(networkService);
});
