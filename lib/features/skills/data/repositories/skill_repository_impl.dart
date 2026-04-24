import '../datasources/skill_remote_datasource.dart';
import '../../domain/repositories/skill_repository.dart';

class SkillRepositoryImpl implements SkillRepository {
  final SkillRemoteDataSource _remoteDataSource;

  SkillRepositoryImpl(this._remoteDataSource);

  @override
  Future<Map<String, dynamic>> getAllSkills() async {
    try {
      return await _remoteDataSource.getAllSkills();
    } catch (e) {
      throw Exception('Failed to get skills: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> getFeaturedSkills() async {
    try {
      return await _remoteDataSource.getFeaturedSkills();
    } catch (e) {
      throw Exception('Failed to get featured skills: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> getSkillsByCategory(String category) async {
    try {
      return await _remoteDataSource.getSkillsByCategory(category);
    } catch (e) {
      throw Exception('Failed to get skills by category: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> getSkillsByLevel(String level) async {
    try {
      return await _remoteDataSource.getSkillsByLevel(level);
    } catch (e) {
      throw Exception('Failed to get skills by level: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> getSkillById(String id) async {
    try {
      return await _remoteDataSource.getSkillById(id);
    } catch (e) {
      throw Exception('Failed to get skill: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> createSkill(Map<String, dynamic> data) async {
    try {
      return await _remoteDataSource.createSkill(data);
    } catch (e) {
      throw Exception('Failed to create skill: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> updateSkill(String id, Map<String, dynamic> data) async {
    try {
      return await _remoteDataSource.updateSkill(id, data);
    } catch (e) {
      throw Exception('Failed to update skill: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteSkill(String id) async {
    try {
      await _remoteDataSource.deleteSkill(id);
    } catch (e) {
      throw Exception('Failed to delete skill: ${e.toString()}');
    }
  }
}
