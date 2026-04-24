import '../repositories/skill_repository.dart';

class CreateSkillUseCase {
  final SkillRepository _repository;

  CreateSkillUseCase(this._repository);

  Future<Map<String, dynamic>> call(Map<String, dynamic> data) async {
    if (data['name'] == null || data['name'].toString().isEmpty) {
      throw Exception('Skill name is required');
    }
    if (data['level'] == null || data['level'].toString().isEmpty) {
      throw Exception('Skill level is required');
    }
    if (data['category'] == null || data['category'].toString().isEmpty) {
      throw Exception('Skill category is required');
    }
    return await _repository.createSkill(data);
  }
}
