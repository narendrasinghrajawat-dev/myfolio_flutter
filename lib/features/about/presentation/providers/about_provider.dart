import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/about_remote_datasource.dart';
import '../../data/repositories/about_repository_impl.dart';
import '../../domain/repositories/about_repository.dart';
import '../../domain/usecases/get_about_usecase.dart';
import '../../domain/usecases/update_about_usecase.dart';
import 'about_notifier.dart';
import 'about_state.dart';

// Remote Data Source Provider
final aboutRemoteDataSourceProvider = Provider<AboutRemoteDataSource>((ref) {
  // TODO: Inject proper HTTP client
  return AboutRemoteDataSourceImpl(null);
});

// Repository Provider
final aboutRepositoryProvider = Provider<AboutRepository>((ref) {
  final remoteDataSource = ref.watch(aboutRemoteDataSourceProvider);
  return AboutRepositoryImpl(remoteDataSource);
});

// Use Cases Providers
final getAboutUseCaseProvider = Provider<GetAboutUseCase>((ref) {
  final repository = ref.watch(aboutRepositoryProvider);
  return GetAboutUseCase(repository);
});

final updateAboutUseCaseProvider = Provider<UpdateAboutUseCase>((ref) {
  final repository = ref.watch(aboutRepositoryProvider);
  return UpdateAboutUseCase(repository);
});

// Notifier Provider
final aboutNotifierProvider = StateNotifierProvider<AboutNotifier, AboutState>((ref) {
  return AboutNotifier(
    getAboutUseCase: ref.watch(getAboutUseCaseProvider),
    updateAboutUseCase: ref.watch(updateAboutUseCaseProvider),
  );
});

// State Providers
final aboutStateProvider = Provider<AboutState>((ref) {
  return ref.watch(aboutNotifierProvider);
});

final aboutProvider = Provider((ref) {
  return ref.watch(aboutStateProvider).about;
});

final aboutLoadingProvider = Provider<bool>((ref) {
  return ref.watch(aboutStateProvider).status == AboutStatus.loading;
});

final aboutErrorProvider = Provider<String?>((ref) {
  return ref.watch(aboutStateProvider).errorMessage;
});
