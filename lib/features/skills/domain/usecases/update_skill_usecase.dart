import '../entities/skill_entity.dart';
import '../repositories/skill_repository.dart';

class UpdateSkillUseCase {
  final SkillRepository _repository;

  UpdateSkillUseCase(this._repository);

  Future<SkillEntity> call(SkillEntity skill) async {
    if (skill.id.isEmpty) {
      throw Exception('Skill ID is required');
    }
    if (skill.name.isEmpty) {
      throw Exception('Skill name is required');
    }
    if (skill.level.isEmpty) {
      throw Exception('Skill level is required');
    }
    return await _repository.updateSkill(skill);
  }
}
