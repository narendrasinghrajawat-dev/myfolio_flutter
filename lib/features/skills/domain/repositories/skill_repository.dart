import '../entities/skill_entity.dart';

abstract class SkillRepository {
  Future<List<SkillEntity>> getSkills();
  Future<SkillEntity?> getSkillById(String id);
  Future<SkillEntity> createSkill(SkillEntity skill);
  Future<SkillEntity> updateSkill(SkillEntity skill);
  Future<void> deleteSkill(String id);
  Future<List<SkillEntity>> getSkillsByCategory(String category);
  Future<List<SkillEntity>> getSkillsByLevel(String level);
  Future<List<SkillEntity>> searchSkills(String query);
}
