abstract class SkillRepository {
  Future<Map<String, dynamic>> getAllSkills();
  Future<Map<String, dynamic>> getFeaturedSkills();
  Future<Map<String, dynamic>> getSkillsByCategory(String category);
  Future<Map<String, dynamic>> getSkillsByLevel(String level);
  Future<Map<String, dynamic>> getSkillById(String id);
  Future<Map<String, dynamic>> createSkill(Map<String, dynamic> data);
  Future<Map<String, dynamic>> updateSkill(String id, Map<String, dynamic> data);
  Future<void> deleteSkill(String id);
}
