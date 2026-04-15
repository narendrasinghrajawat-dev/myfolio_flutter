import '../repositories/skill_repository.dart';

class DeleteSkillUseCase {
  final SkillRepository _repository;

  DeleteSkillUseCase(this._repository);

  Future<void> call(String id) async {
    if (id.isEmpty) {
      throw Exception('Skill ID is required');
    }
    await _repository.deleteSkill(id);
  }
}
