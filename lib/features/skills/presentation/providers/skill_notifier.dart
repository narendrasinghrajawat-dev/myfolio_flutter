import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/get_skills_usecase.dart';
import '../../domain/usecases/create_skill_usecase.dart';
import '../../domain/usecases/update_skill_usecase.dart';
import '../../domain/usecases/delete_skill_usecase.dart';
import 'skill_state.dart';

class SkillNotifier extends StateNotifier<SkillState> {
  final GetSkillsUseCase _getSkillsUseCase;
  final CreateSkillUseCase _createSkillUseCase;
  final UpdateSkillUseCase _updateSkillUseCase;
  final DeleteSkillUseCase _deleteSkillUseCase;

  SkillNotifier({
    required GetSkillsUseCase getSkillsUseCase,
    required CreateSkillUseCase createSkillUseCase,
    required UpdateSkillUseCase updateSkillUseCase,
    required DeleteSkillUseCase deleteSkillUseCase,
  }) : _getSkillsUseCase = getSkillsUseCase,
       _createSkillUseCase = createSkillUseCase,
       _updateSkillUseCase = updateSkillUseCase,
       _deleteSkillUseCase = deleteSkillUseCase,
       super(const SkillState(status: SkillStatus.initial));

  Future<void> getSkills() async {
    state = state.copyWith(status: SkillStatus.loading);
    
    try {
      final skills = await _getSkillsUseCase();
      state = state.copyWith(
        status: SkillStatus.loaded,
        skills: skills,
      );
    } catch (e) {
      state = state.copyWith(
        status: SkillStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> createSkill(Map<String, dynamic> data) async {
    state = state.copyWith(status: SkillStatus.loading);
    
    try {
      final createdSkill = await _createSkillUseCase(data);
      state = state.copyWith(
        status: SkillStatus.loaded,
        skills: createdSkill,
      );
    } catch (e) {
      state = state.copyWith(
        status: SkillStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> updateSkill(String id, Map<String, dynamic> data) async {
    state = state.copyWith(status: SkillStatus.loading);
    
    try {
      final updatedSkill = await _updateSkillUseCase(id, data);
      state = state.copyWith(
        status: SkillStatus.loaded,
        skills: updatedSkill,
      );
    } catch (e) {
      state = state.copyWith(
        status: SkillStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> deleteSkill(String id) async {
    state = state.copyWith(status: SkillStatus.loading);
    
    try {
      await _deleteSkillUseCase(id);
      state = state.copyWith(
        status: SkillStatus.loaded,
        skills: null,
      );
    } catch (e) {
      state = state.copyWith(
        status: SkillStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  void selectSkill(Map<String, dynamic> skill) {
    state = state.copyWith(selectedSkill: skill);
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}
