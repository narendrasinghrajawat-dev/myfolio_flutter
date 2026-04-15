import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/datasources/auth_remote_datasource.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../data/models/user_model.dart';
import 'auth_notifier.dart';

// Data source provider
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl();
});

// Repository provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  return AuthRepositoryImpl(remoteDataSource);
});

// Notifier provider
final authNotifierProvider = StateNotifierProvider<AuthNotifier>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthNotifier(
    signInUseCase: SignInUseCase(repository),
    registerUseCase: RegisterUseCase(repository),
    signOutUseCase: SignOutUseCase(repository),
    getCurrentUserUseCase: GetCurrentUserUseCase(repository),
  );
});

// State provider
final authStateProvider = Provider<AuthState>((ref) {
  return ref.watch(authNotifierProvider);
});

// User provider
final userProvider = Provider<UserEntity?>((ref) {
  return ref.watch(authStateProvider).user;
});

// Authenticated provider
final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(authStateProvider).status == AuthStatus.authenticated;
});

// User ID provider
final userIdProvider = Provider<String?>((ref) {
  return ref.watch(authStateProvider).user?.id;
});

// User email provider
final userEmailProvider = Provider<String?>((ref) {
  return ref.watch(authStateProvider).user?.email;
});

// User display name provider
final userDisplayNameProvider = Provider<String?>((ref) {
  return ref.watch(authStateProvider).user?.displayName;
});

// User photo URL provider
final userPhotoURLProvider = Provider<String?>((ref) {
  return ref.watch(authStateProvider).user?.photoURL;
});

// Email verified provider
final isEmailVerifiedProvider = Provider<bool>((ref) {
  return ref.watch(authStateProvider).user?.emailVerified ?? false;
});

// Error message provider
final authErrorMessageProvider = Provider<String?>((ref) {
  return ref.watch(authStateProvider).errorMessage;
});
