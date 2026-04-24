import '../services/skill_api_service.dart';

abstract class SkillRemoteDataSource {
  Future<Map<String, dynamic>> getAllSkills();
  Future<Map<String, dynamic>> getFeaturedSkills();
  Future<Map<String, dynamic>> getSkillsByCategory(String category);
  Future<Map<String, dynamic>> getSkillsByLevel(String level);
  Future<Map<String, dynamic>> getSkillById(String id);
  Future<Map<String, dynamic>> createSkill(Map<String, dynamic> data);
  Future<Map<String, dynamic>> updateSkill(String id, Map<String, dynamic> data);
  Future<void> deleteSkill(String id);
}

class SkillRemoteDataSourceImpl implements SkillRemoteDataSource {
  final SkillApiService _skillApiService;

  SkillRemoteDataSourceImpl(this._skillApiService);

  @override
  Future<Map<String, dynamic>> getAllSkills() async {
    try {
      return await _skillApiService.getAllSkills();
    } catch (e) {
      throw Exception('Failed to get skills: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> getFeaturedSkills() async {
    try {
      return await _skillApiService.getFeaturedSkills();
    } catch (e) {
      throw Exception('Failed to get featured skills: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> getSkillsByCategory(String category) async {
    try {
      return await _skillApiService.getSkillsByCategory(category);
    } catch (e) {
      throw Exception('Failed to get skills by category: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> getSkillsByLevel(String level) async {
    try {
      return await _skillApiService.getSkillsByLevel(level);
    } catch (e) {
      throw Exception('Failed to get skills by level: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> getSkillById(String id) async {
    try {
      return await _skillApiService.getSkillById(id);
    } catch (e) {
      throw Exception('Failed to get skill: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> createSkill(Map<String, dynamic> data) async {
    try {
      return await _skillApiService.createSkill(data);
    } catch (e) {
      throw Exception('Failed to create skill: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> updateSkill(String id, Map<String, dynamic> data) async {
    try {
      return await _skillApiService.updateSkill(id, data);
    } catch (e) {
      throw Exception('Failed to update skill: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteSkill(String id) async {
    try {
      await _skillApiService.deleteSkill(id);
    } catch (e) {
      throw Exception('Failed to delete skill: ${e.toString()}');
    }
  }
}
