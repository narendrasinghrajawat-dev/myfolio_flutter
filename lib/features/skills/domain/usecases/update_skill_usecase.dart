import '../repositories/skill_repository.dart';

class UpdateSkillUseCase {
  final SkillRepository _repository;

  UpdateSkillUseCase(this._repository);

  Future<Map<String, dynamic>> call(String id, Map<String, dynamic> data) async {
    if (id.isEmpty) {
      throw Exception('Skill ID is required');
    }
    if (data['name'] == null || data['name'].toString().isEmpty) {
      throw Exception('Skill name is required');
    }
    if (data['level'] == null || data['level'].toString().isEmpty) {
      throw Exception('Skill level is required');
    }
    return await _repository.updateSkill(id, data);
  }
}
