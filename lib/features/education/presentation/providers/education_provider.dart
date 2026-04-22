import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/education_remote_datasource.dart';
import '../../data/repositories/education_repository_impl.dart';
import '../../domain/repositories/education_repository.dart';
import '../../domain/usecases/get_education_usecase.dart';
import '../../domain/usecases/create_education_usecase.dart';
import '../../domain/usecases/update_education_usecase.dart';
import '../../domain/usecases/delete_education_usecase.dart';
import 'education_notifier.dart';
import 'education_state.dart';

// Remote Data Source Provider
final educationRemoteDataSourceProvider = Provider<EducationRemoteDataSource>((ref) {
  return EducationRemoteDataSourceImpl(null);
});

// Repository Provider
final educationRepositoryProvider = Provider<EducationRepository>((ref) {
  final remoteDataSource = ref.watch(educationRemoteDataSourceProvider);
  return EducationRepositoryImpl(remoteDataSource);
});

// Use Cases Providers
final getEducationUseCaseProvider = Provider<GetEducationUseCase>((ref) {
  final repository = ref.watch(educationRepositoryProvider);
  return GetEducationUseCase(repository);
});

final createEducationUseCaseProvider = Provider<CreateEducationUseCase>((ref) {
  final repository = ref.watch(educationRepositoryProvider);
  return CreateEducationUseCase(repository);
});

final updateEducationUseCaseProvider = Provider<UpdateEducationUseCase>((ref) {
  final repository = ref.watch(educationRepositoryProvider);
  return UpdateEducationUseCase(repository);
});

final deleteEducationUseCaseProvider = Provider<DeleteEducationUseCase>((ref) {
  final repository = ref.watch(educationRepositoryProvider);
  return DeleteEducationUseCase(repository);
});

// Notifier Provider
final educationNotifierProvider = StateNotifierProvider<EducationNotifier, EducationState>((ref) {
  return EducationNotifier(
    getEducationUseCase: ref.watch(getEducationUseCaseProvider),
    createEducationUseCase: ref.watch(createEducationUseCaseProvider),
    updateEducationUseCase: ref.watch(updateEducationUseCaseProvider),
    deleteEducationUseCase: ref.watch(deleteEducationUseCaseProvider),
  );
});

// State Providers
final educationStateProvider = Provider<EducationState>((ref) {
  return ref.watch(educationNotifierProvider);
});

final educationListProvider = Provider((ref) {
  return ref.watch(educationStateProvider).educationList;
});

final educationLoadingProvider = Provider<bool>((ref) {
  return ref.watch(educationStateProvider).status == EducationStatus.loading;
});

final educationErrorProvider = Provider<String?>((ref) {
  return ref.watch(educationStateProvider).errorMessage;
});
