import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/api_urls.dart';
import '../../data/datasources/project_remote_datasource.dart';
import '../../data/repositories/project_repository_impl.dart';
import '../../domain/repositories/project_repository.dart';
import '../../domain/usecases/get_projects_usecase.dart';
import '../../domain/usecases/create_project_usecase.dart';
import '../../domain/usecases/update_project_usecase.dart';
import '../../domain/usecases/delete_project_usecase.dart';
import 'project_notifier.dart';
import 'project_state.dart';

// Remote Data Source Provider
final projectRemoteDataSourceProvider = Provider<ProjectRemoteDataSource>((ref) {
  return ProjectRemoteDataSourceImpl(null);
});

// Repository Provider
final projectRepositoryProvider = Provider<ProjectRepository>((ref) {
  final remoteDataSource = ref.watch(projectRemoteDataSourceProvider);
  return ProjectRepositoryImpl(remoteDataSource);
});

// Use Cases Providers
final getProjectsUseCaseProvider = Provider<GetProjectsUseCase>((ref) {
  final repository = ref.watch(projectRepositoryProvider);
  return GetProjectsUseCase(repository);
});

final createProjectUseCaseProvider = Provider<CreateProjectUseCase>((ref) {
  final repository = ref.watch(projectRepositoryProvider);
  return CreateProjectUseCase(repository);
});

final updateProjectUseCaseProvider = Provider<UpdateProjectUseCase>((ref) {
  final repository = ref.watch(projectRepositoryProvider);
  return UpdateProjectUseCase(repository);
});

final deleteProjectUseCaseProvider = Provider<DeleteProjectUseCase>((ref) {
  final repository = ref.watch(projectRepositoryProvider);
  return DeleteProjectUseCase(repository);
});

// Notifier Provider
final projectNotifierProvider = StateNotifierProvider<ProjectNotifier, ProjectState>((ref) {
  return ProjectNotifier(
    getProjectsUseCase: ref.watch(getProjectsUseCaseProvider),
    createProjectUseCase: ref.watch(createProjectUseCaseProvider),
    updateProjectUseCase: ref.watch(updateProjectUseCaseProvider),
    deleteProjectUseCase: ref.watch(deleteProjectUseCaseProvider),
  );
});

// State Providers
final projectStateProvider = Provider<ProjectState>((ref) {
  return ref.watch(projectNotifierProvider);
});

final projectsProvider = Provider((ref) {
  return ref.watch(projectStateProvider).projects;
});

final projectLoadingProvider = Provider<bool>((ref) {
  return ref.watch(projectStateProvider).status == ProjectStatus.loading;
});

final projectErrorProvider = Provider<String?>((ref) {
  return ref.watch(projectStateProvider).errorMessage;
});
