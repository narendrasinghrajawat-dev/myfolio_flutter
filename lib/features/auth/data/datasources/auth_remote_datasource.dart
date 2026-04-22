import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel?> signInWithEmail(String email, String password);
  Future<UserModel?> registerWithEmail(String email, String password, String? displayName);
  Future<void> signOut();
  Future<void> resetPassword(String email);
  Future<UserModel?> getCurrentUser();
  Future<void> sendEmailVerification();
  Future<bool> isEmailVerified();
  Future<String?> getIdToken();
  Future<void> updateProfile({String? displayName, String? photoURL});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;

  AuthRemoteDataSourceImpl(this._firebaseAuth);

  @override
  Future<UserModel?> signInWithEmail(String email, String password) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      final user = result.user;
      if (user != null) {
        return UserModel.fromFirebaseUser(user);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to sign in: ${e.toString()}');
    }
  }

  @override
  Future<UserModel?> registerWithEmail(String email, String password, String? displayName) async {
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      final user = result.user;
      if (user != null) {
        if (displayName != null && displayName!.isNotEmpty) {
          await user.updateDisplayName(displayName);
        }
        return UserModel.fromFirebaseUser(user);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to register: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception('Failed to sign out: ${e.toString()}');
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception('Failed to send reset email: ${e.toString()}');
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final user = _firebaseAuth.currentUser;
      return user != null ? UserModel.fromFirebaseUser(user) : null;
    } catch (e) {
      throw Exception('Failed to get current user: ${e.toString()}');
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
    } catch (e) {
      throw Exception('Failed to send verification email: ${e.toString()}');
    }
  }

  @override
  Future<bool> isEmailVerified() async {
    try {
      final user = _firebaseAuth.currentUser;
      return user?.emailVerified ?? false;
    } catch (e) {
      throw Exception('Failed to check email verification: ${e.toString()}');
    }
  }

  @override
  Future<String?> getIdToken() async {
    try {
      final user = _firebaseAuth.currentUser;
      return await user?.getIdToken();
    } catch (e) {
      throw Exception('Failed to get ID token: ${e.toString()}');
    }
  }

  @override
  Future<void> updateProfile({String? displayName, String? photoURL}) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        await user.updateProfile(
          displayName: displayName?.isNotEmpty == true ? displayName : null,
          photoURL: photoURL?.isNotEmpty == true ? photoURL : null,
        );
      }
    } catch (e) {
      throw Exception('Failed to update profile: ${e.toString()}');
    }
  }
}
