import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity?> signInWithEmail(String email, String password);
  Future<UserEntity?> registerWithEmail(String email, String password, String? displayName);
  Future<void> signOut();
  Future<void> resetPassword(String email);
  Future<UserEntity?> getCurrentUser();
  Future<void> sendEmailVerification();
  Future<bool> isEmailVerified();
  Future<String?> getIdToken();
  Future<void> updateProfile({String? displayName, String? photoURL});
}
