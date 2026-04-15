import '../datasources/skill_remote_datasource.dart';
import '../../domain/repositories/skill_repository.dart';
import '../../domain/entities/skill_entity.dart';

class SkillRepositoryImpl implements SkillRepository {
  final SkillRemoteDataSource _remoteDataSource;

  SkillRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<SkillEntity>> getSkills() async {
    try {
      final skillModels = await _remoteDataSource.getSkills();
      return skillModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to get skills: ${e.toString()}');
    }
  }

  @override
  Future<SkillEntity?> getSkillById(String id) async {
    try {
      final skillModel = await _remoteDataSource.getSkillById(id);
      return skillModel?.toEntity();
    } catch (e) {
      throw Exception('Failed to get skill by id: ${e.toString()}');
    }
  }

  @override
  Future<SkillEntity> createSkill(SkillEntity skill) async {
    try {
      final skillModel = SkillModel(
        id: skill.id,
        name: skill.name,
        level: skill.level,
        category: skill.category,
        yearsOfExperience: skill.yearsOfExperience,
        description: skill.description,
        icon: skill.icon,
        sortOrder: skill.sortOrder,
        createdAt: skill.createdAt,
        updatedAt: skill.updatedAt,
      );
      final createdModel = await _remoteDataSource.createSkill(skillModel);
      return createdModel.toEntity();
    } catch (e) {
      throw Exception('Failed to create skill: ${e.toString()}');
    }
  }

  @override
  Future<SkillEntity> updateSkill(SkillEntity skill) async {
    try {
      final skillModel = SkillModel(
        id: skill.id,
        name: skill.name,
        level: skill.level,
        category: skill.category,
        yearsOfExperience: skill.yearsOfExperience,
        description: skill.description,
        icon: skill.icon,
        sortOrder: skill.sortOrder,
        createdAt: skill.createdAt,
        updatedAt: skill.updatedAt,
      );
      final updatedModel = await _remoteDataSource.updateSkill(skillModel);
      return updatedModel.toEntity();
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

  @override
  Future<List<SkillEntity>> getSkillsByCategory(String category) async {
    try {
      final skillModels = await _remoteDataSource.getSkillsByCategory(category);
      return skillModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to get skills by category: ${e.toString()}');
    }
  }

  @override
  Future<List<SkillEntity>> getSkillsByLevel(String level) async {
    try {
      final skillModels = await _remoteDataSource.getSkillsByLevel(level);
      return skillModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to get skills by level: ${e.toString()}');
    }
  }

  @override
  Future<List<SkillEntity>> searchSkills(String query) async {
    try {
      final skillModels = await _remoteDataSource.searchSkills(query);
      return skillModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to search skills: ${e.toString()}');
    }
  }
}
