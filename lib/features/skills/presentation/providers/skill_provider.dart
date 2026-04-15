import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/api_urls.dart';
import '../../data/datasources/skill_remote_datasource.dart';
import '../../data/repositories/skill_repository_impl.dart';
import '../../domain/repositories/skill_repository.dart';
import '../../domain/usecases/get_skills_usecase.dart';
import '../../domain/usecases/create_skill_usecase.dart';
import '../../domain/usecases/update_skill_usecase.dart';
import '../../domain/usecases/delete_skill_usecase.dart';
import 'skill_notifier.dart';
import 'skill_state.dart';

// Remote Data Source Provider
final skillRemoteDataSourceProvider = Provider<SkillRemoteDataSource>((ref) {
  return SkillRemoteDataSourceImpl(null);
});

// Repository Provider
final skillRepositoryProvider = Provider<SkillRepository>((ref) {
  final remoteDataSource = ref.watch(skillRemoteDataSourceProvider);
  return SkillRepositoryImpl(remoteDataSource);
});

// Use Cases Providers
final getSkillsUseCaseProvider = Provider<GetSkillsUseCase>((ref) {
  final repository = ref.watch(skillRepositoryProvider);
  return GetSkillsUseCase(repository);
});

final createSkillUseCaseProvider = Provider<CreateSkillUseCase>((ref) {
  final repository = ref.watch(skillRepositoryProvider);
  return CreateSkillUseCase(repository);
});

final updateSkillUseCaseProvider = Provider<UpdateSkillUseCase>((ref) {
  final repository = ref.watch(skillRepositoryProvider);
  return UpdateSkillUseCase(repository);
});

final deleteSkillUseCaseProvider = Provider<DeleteSkillUseCase>((ref) {
  final repository = ref.watch(skillRepositoryProvider);
  return DeleteSkillUseCase(repository);
});

// Notifier Provider
final skillNotifierProvider = StateNotifierProvider<SkillNotifier, SkillState>((ref) {
  return SkillNotifier(
    getSkillsUseCase: ref.watch(getSkillsUseCaseProvider),
    createSkillUseCase: ref.watch(createSkillUseCaseProvider),
    updateSkillUseCase: ref.watch(updateSkillUseCaseProvider),
    deleteSkillUseCase: ref.watch(deleteSkillUseCaseProvider),
  );
});

// State Providers
final skillStateProvider = Provider<SkillState>((ref) {
  return ref.watch(skillNotifierProvider);
});

final skillsProvider = Provider((ref) {
  return ref.watch(skillStateProvider).skills;
});

final skillLoadingProvider = Provider<bool>((ref) {
  return ref.watch(skillStateProvider).status == SkillStatus.loading;
});

final skillErrorProvider = Provider<String?>((ref) {
  return ref.watch(skillStateProvider).errorMessage;
});
