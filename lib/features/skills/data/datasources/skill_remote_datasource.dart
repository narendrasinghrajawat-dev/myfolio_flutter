import '../models/skill_model.dart';

abstract class SkillRemoteDataSource {
  Future<List<SkillModel>> getSkills();
  Future<SkillModel?> getSkillById(String id);
  Future<SkillModel> createSkill(SkillModel skill);
  Future<SkillModel> updateSkill(SkillModel skill);
  Future<void> deleteSkill(String id);
  Future<List<SkillModel>> getSkillsByCategory(String category);
  Future<List<SkillModel>> getSkillsByLevel(String level);
  Future<List<SkillModel>> searchSkills(String query);
}

class SkillRemoteDataSourceImpl implements SkillRemoteDataSource {
  final dynamic _httpClient;

  SkillRemoteDataSourceImpl(this._httpClient);

  @override
  Future<List<SkillModel>> getSkills() async {
    try {
      final response = await _httpClient.get('/skills');
      return (response.data['data'] as List<dynamic>)
          .map((json) => SkillModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to get skills: ${e.toString()}');
    }
  }

  @override
  Future<SkillModel?> getSkillById(String id) async {
    try {
      final response = await _httpClient.get('/skills/$id');
      return SkillModel.fromJson(response.data['data']);
    } catch (e) {
      throw Exception('Failed to get skill by id: ${e.toString()}');
    }
  }

  @override
  Future<SkillModel> createSkill(SkillModel skill) async {
    try {
      final response = await _httpClient.post('/skills', data: skill.toJson());
      return SkillModel.fromJson(response.data['data']);
    } catch (e) {
      throw Exception('Failed to create skill: ${e.toString()}');
    }
  }

  @override
  Future<SkillModel> updateSkill(SkillModel skill) async {
    try {
      final response = await _httpClient.put('/skills/${skill.id}', data: skill.toJson());
      return SkillModel.fromJson(response.data['data']);
    } catch (e) {
      throw Exception('Failed to update skill: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteSkill(String id) async {
    try {
      await _httpClient.delete('/skills/$id');
    } catch (e) {
      throw Exception('Failed to delete skill: ${e.toString()}');
    }
  }

  @override
  Future<List<SkillModel>> getSkillsByCategory(String category) async {
    try {
      final response = await _httpClient.get('/skills/category/$category');
      return (response.data['data'] as List<dynamic>)
          .map((json) => SkillModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to get skills by category: ${e.toString()}');
    }
  }

  @override
  Future<List<SkillModel>> getSkillsByLevel(String level) async {
    try {
      final response = await _httpClient.get('/skills/level/$level');
      return (response.data['data'] as List<dynamic>)
          .map((json) => SkillModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to get skills by level: ${e.toString()}');
    }
  }

  @override
  Future<List<SkillModel>> searchSkills(String query) async {
    try {
      final response = await _httpClient.get('/skills/search', queryParameters: {
        'q': query,
      });
      return (response.data['data'] as List<dynamic>)
          .map((json) => SkillModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to search skills: ${e.toString()}');
    }
  }
}
