import '../datasources/auth_remote_datasource.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user_entity.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<UserEntity?> signInWithEmail(String email, String password) async {
    try {
      final userModel = await _remoteDataSource.signInWithEmail(email, password);
      return userModel?.toEntity();
    } catch (e) {
      throw Exception('Sign in failed: ${e.toString()}');
    }
  }

  @override
  Future<UserEntity?> registerWithEmail(String email, String password, String? displayName) async {
    try {
      final userModel = await _remoteDataSource.registerWithEmail(email, password, displayName);
      return userModel?.toEntity();
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
  Future<UserEntity?> getCurrentUser() async {
    try {
      final userModel = await _remoteDataSource.getCurrentUser();
      return userModel?.toEntity();
    } catch (e) {
      throw Exception('Failed to get current user: ${e.toString()}');
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    try {
      await _remoteDataSource.sendEmailVerification();
    } catch (e) {
      throw Exception('Email verification failed: ${e.toString()}');
    }
  }

  @override
  Future<bool> isEmailVerified() async {
    try {
      return await _remoteDataSource.isEmailVerified();
    } catch (e) {
      throw Exception('Email verification check failed: ${e.toString()}');
    }
  }

  @override
  Future<String?> getIdToken() async {
    try {
      return await _remoteDataSource.getIdToken();
    } catch (e) {
      throw Exception('Failed to get ID token: ${e.toString()}');
    }
  }

  @override
  Future<void> updateProfile({String? displayName, String? photoURL}) async {
    try {
      await _remoteDataSource.updateProfile(displayName: displayName, photoURL: photoURL);
    } catch (e) {
      throw Exception('Profile update failed: ${e.toString()}');
    }
  }
}
