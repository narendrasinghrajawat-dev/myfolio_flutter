import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/services/admin_auth_service.dart';
import '../../data/models/admin_model.dart';
import '../../../../core/services/network_service.dart';

/// Admin Auth states
enum AdminAuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error,
}

/// Admin Auth state class
class AdminAuthState {
  final AdminAuthStatus status;
  final AdminModel? admin;
  final String? errorMessage;

  AdminAuthState({
    this.status = AdminAuthStatus.initial,
    this.admin,
    this.errorMessage,
  });

  AdminAuthState copyWith({
    AdminAuthStatus? status,
    AdminModel? admin,
    String? errorMessage,
  }) {
    return AdminAuthState(
      status: status ?? this.status,
      admin: admin ?? this.admin,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  bool get isAuthenticated => status == AdminAuthStatus.authenticated;
  bool get isLoading => status == AdminAuthStatus.loading;
  bool get hasError => status == AdminAuthStatus.error;
}

/// Admin auth controller with Riverpod
class AdminAuthController extends StateNotifier<AdminAuthState> {
  final AdminAuthService _adminAuthService;
  final NetworkService _networkService;

  AdminAuthController(this._adminAuthService, this._networkService)
      : super(AdminAuthState()) {
    _checkAuthStatus();
  }

  /// Check authentication status
  Future<void> _checkAuthStatus() async {
    try {
      state = state.copyWith(status: AdminAuthStatus.loading);
      final adminData = await _adminAuthService.getCurrentAdmin();
      state = state.copyWith(
        status: AdminAuthStatus.authenticated,
        admin: AdminModel.fromJson(adminData),
      );
    } catch (e) {
      state = state.copyWith(status: AdminAuthStatus.unauthenticated);
    }
  }

  /// Admin login
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      state = state.copyWith(status: AdminAuthStatus.loading, errorMessage: null);
      
      final response = await _adminAuthService.login(
        email: email,
        password: password,
      );

      final tokens = response['tokens'] as Map<String, dynamic>;
      final accessToken = tokens['accessToken'] as String;

      // Set auth token in network service
      _networkService.setAuthToken(accessToken);

      // Store tokens locally
      // TODO: Store tokens securely

      final adminData = response['admin'] as Map<String, dynamic>;
      state = state.copyWith(
        status: AdminAuthStatus.authenticated,
        admin: AdminModel.fromJson(adminData),
      );

      return true;
    } catch (e) {
      state = state.copyWith(
        status: AdminAuthStatus.error,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  /// Admin logout
  Future<void> logout() async {
    try {
      await _adminAuthService.logout();
    } catch (e) {
      // Ignore logout errors
    } finally {
      _networkService.clearAuthToken();
      // Clear stored tokens
      // TODO: Clear stored tokens
      state = AdminAuthState(status: AdminAuthStatus.unauthenticated);
    }
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

/// Provider for AdminAuthController
final adminAuthControllerProvider = StateNotifierProvider<AdminAuthController, AdminAuthState>((ref) {
  final adminAuthService = ref.watch(adminAuthProvider);
  final networkService = ref.watch(networkServiceProvider);
  return AdminAuthController(adminAuthService, networkService);
});
