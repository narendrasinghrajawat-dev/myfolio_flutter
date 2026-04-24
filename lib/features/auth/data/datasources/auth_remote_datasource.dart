import '../services/auth_api_service.dart';

abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> signInWithEmail(String email, String password);
  Future<Map<String, dynamic>> registerWithEmail(String email, String password, String firstName, String lastName, String displayName);
  Future<void> signOut();
  Future<void> resetPassword(String email);
  Future<Map<String, dynamic>> getCurrentUser();
  Future<void> sendEmailVerification(String token);
  Future<void> forgotPassword(String email);
  Future<void> resetPasswordWithToken(String token, String newPassword);
  Future<void> changePassword(String currentPassword, String newPassword);
  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> data);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthApiService _authApiService;

  AuthRemoteDataSourceImpl(this._authApiService);

  @override
  Future<Map<String, dynamic>> signInWithEmail(String email, String password) async {
    try {
      return await _authApiService.login(email: email, password: password);
    } catch (e) {
      throw Exception('Failed to sign in: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> registerWithEmail(String email, String password, String firstName, String lastName, String displayName) async {
    try {
      return await _authApiService.register(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
      );
    } catch (e) {
      throw Exception('Failed to register: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _authApiService.logout();
    } catch (e) {
      throw Exception('Failed to sign out: ${e.toString()}');
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _authApiService.forgotPassword(email);
    } catch (e) {
      throw Exception('Failed to send reset email: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> getCurrentUser() async {
    try {
      return await _authApiService.getCurrentUser();
    } catch (e) {
      throw Exception('Failed to get current user: ${e.toString()}');
    }
  }

  @override
  Future<void> sendEmailVerification(String token) async {
    try {
      await _authApiService.verifyEmail(token);
    } catch (e) {
      throw Exception('Failed to send verification email: ${e.toString()}');
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _authApiService.forgotPassword(email);
    } catch (e) {
      throw Exception('Failed to send forgot password email: ${e.toString()}');
    }
  }

  @override
  Future<void> resetPasswordWithToken(String token, String newPassword) async {
    try {
      await _authApiService.resetPassword(token: token, newPassword: newPassword);
    } catch (e) {
      throw Exception('Failed to reset password: ${e.toString()}');
    }
  }

  @override
  Future<void> changePassword(String currentPassword, String newPassword) async {
    try {
      await _authApiService.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
    } catch (e) {
      throw Exception('Failed to change password: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> data) async {
    try {
      return await _authApiService.updateProfile(data);
    } catch (e) {
      throw Exception('Failed to update profile: ${e.toString()}');
    }
  }
}
