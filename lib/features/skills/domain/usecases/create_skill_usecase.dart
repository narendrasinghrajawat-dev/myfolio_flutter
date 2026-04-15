import '../entities/skill_entity.dart';
import '../repositories/skill_repository.dart';

class CreateSkillUseCase {
  final SkillRepository _repository;

  CreateSkillUseCase(this._repository);

  Future<SkillEntity> call(SkillEntity skill) async {
    if (skill.name.isEmpty) {
      throw Exception('Skill name is required');
    }
    if (skill.level.isEmpty) {
      throw Exception('Skill level is required');
    }
    if (skill.category.isEmpty) {
      throw Exception('Skill category is required');
    }
    return await _repository.createSkill(skill);
  }
}
