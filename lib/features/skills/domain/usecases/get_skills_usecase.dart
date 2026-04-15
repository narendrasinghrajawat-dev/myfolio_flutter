import '../entities/skill_entity.dart';
import '../repositories/skill_repository.dart';

class GetSkillsUseCase {
  final SkillRepository _repository;

  GetSkillsUseCase(this._repository);

  Future<List<SkillEntity>> call() async {
    return await _repository.getSkills();
  }
}
