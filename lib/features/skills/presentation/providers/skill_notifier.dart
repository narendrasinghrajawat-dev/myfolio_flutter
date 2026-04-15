import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/skill_entity.dart';
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
  }) : super(const SkillState(status: SkillStatus.initial)) {
    _getSkillsUseCase = getSkillsUseCase;
    _createSkillUseCase = createSkillUseCase;
    _updateSkillUseCase = updateSkillUseCase;
    _deleteSkillUseCase = deleteSkillUseCase;
  }

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

  Future<void> createSkill(SkillEntity skill) async {
    state = state.copyWith(status: SkillStatus.loading);
    
    try {
      final createdSkill = await _createSkillUseCase(skill);
      state = state.copyWith(
        status: SkillStatus.loaded,
        skills: [...state.skills, createdSkill],
      );
    } catch (e) {
      state = state.copyWith(
        status: SkillStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> updateSkill(SkillEntity skill) async {
    state = state.copyWith(status: SkillStatus.loading);
    
    try {
      final updatedSkill = await _updateSkillUseCase(skill);
      final updatedSkills = state.skills.map((s) => 
        s.id == skill.id ? updatedSkill : s
      ).toList();
      state = state.copyWith(
        status: SkillStatus.loaded,
        skills: updatedSkills,
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
      final updatedSkills = state.skills.where((s) => s.id != id).toList();
      state = state.copyWith(
        status: SkillStatus.loaded,
        skills: updatedSkills,
      );
    } catch (e) {
      state = state.copyWith(
        status: SkillStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  void selectSkill(SkillEntity skill) {
    state = state.copyWith(selectedSkill: skill);
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}
