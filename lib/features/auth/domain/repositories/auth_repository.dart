abstract class AuthRepository {
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
