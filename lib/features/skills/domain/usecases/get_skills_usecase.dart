import '../repositories/skill_repository.dart';

class GetSkillsUseCase {
  final SkillRepository _repository;

  GetSkillsUseCase(this._repository);

  Future<Map<String, dynamic>> call() async {
    return await _repository.getAllSkills();
  }
}
