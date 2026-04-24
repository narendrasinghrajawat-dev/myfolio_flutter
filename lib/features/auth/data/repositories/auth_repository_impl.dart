import '../datasources/auth_remote_datasource.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<Map<String, dynamic>> signInWithEmail(String email, String password) async {
    try {
      return await _remoteDataSource.signInWithEmail(email, password);
    } catch (e) {
      throw Exception('Sign in failed: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> registerWithEmail(String email, String password, String firstName, String lastName, String displayName) async {
    try {
      return await _remoteDataSource.registerWithEmail(email, password, firstName, lastName, displayName);
    } catch (e) {
      throw Exception('Registration failed: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _remoteDataSource.signOut();
    } catch (e) {
      throw Exception('Sign out failed: ${e.toString()}');
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _remoteDataSource.resetPassword(email);
    } catch (e) {
      throw Exception('Password reset failed: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> getCurrentUser() async {
    try {
      return await _remoteDataSource.getCurrentUser();
    } catch (e) {
      throw Exception('Failed to get current user: ${e.toString()}');
    }
  }

  @override
  Future<void> sendEmailVerification(String token) async {
    try {
      await _remoteDataSource.sendEmailVerification(token);
    } catch (e) {
      throw Exception('Email verification failed: ${e.toString()}');
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _remoteDataSource.forgotPassword(email);
    } catch (e) {
      throw Exception('Forgot password failed: ${e.toString()}');
    }
  }

  @override
  Future<void> resetPasswordWithToken(String token, String newPassword) async {
    try {
      await _remoteDataSource.resetPasswordWithToken(token, newPassword);
    } catch (e) {
      throw Exception('Password reset with token failed: ${e.toString()}');
    }
  }

  @override
  Future<void> changePassword(String currentPassword, String newPassword) async {
    try {
      await _remoteDataSource.changePassword(currentPassword, newPassword);
    } catch (e) {
      throw Exception('Change password failed: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> data) async {
    try {
      return await _remoteDataSource.updateProfile(data);
    } catch (e) {
      throw Exception('Profile update failed: ${e.toString()}');
    }
  }
}
