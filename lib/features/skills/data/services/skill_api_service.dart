import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/network_service.dart';
import '../../../../core/constants/api_endpoints.dart';

/// Skill API service for making skill-related API calls
class SkillApiService {
  final NetworkService _networkService;

  SkillApiService(this._networkService);

  /// Get all skills
  Future<Map<String, dynamic>> getAllSkills() async {
    try {
      final response = await _networkService.get<Map<String, dynamic>>(
        ApiEndpoints.getSkills,
      );
      return response as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to get skills: ${e.toString()}');
    }
  }

  /// Get featured skills
  Future<Map<String, dynamic>> getFeaturedSkills() async {
    try {
      final response = await _networkService.get<Map<String, dynamic>>(
        ApiEndpoints.getFeaturedSkills,
      );
      return response as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to get featured skills: ${e.toString()}');
    }
  }

  /// Get skills by category
  Future<Map<String, dynamic>> getSkillsByCategory(String category) async {
    try {
      final response = await _networkService.get<Map<String, dynamic>>(
        ApiEndpoints.getSkillsByCategory.replaceAll('{category}', category),
      );
      return response as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to get skills by category: ${e.toString()}');
    }
  }

  /// Get skills by level
  Future<Map<String, dynamic>> getSkillsByLevel(String level) async {
    try {
      final response = await _networkService.get<Map<String, dynamic>>(
        ApiEndpoints.getSkillsByLevel.replaceAll('{level}', level),
      );
      return response as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to get skills by level: ${e.toString()}');
    }
  }

  /// Get skill by ID
  Future<Map<String, dynamic>> getSkillById(String id) async {
    try {
      final response = await _networkService.get<Map<String, dynamic>>(
        ApiEndpoints.getSkillById.replaceAll('{id}', id),
      );
      return response as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to get skill: ${e.toString()}');
    }
  }

  /// Create skill
  Future<Map<String, dynamic>> createSkill(Map<String, dynamic> data) async {
    try {
      final response = await _networkService.post<Map<String, dynamic>>(
        ApiEndpoints.createSkill,
        data: data,
      );
      return response as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to create skill: ${e.toString()}');
    }
  }

  /// Update skill
  Future<Map<String, dynamic>> updateSkill(String id, Map<String, dynamic> data) async {
    try {
      final response = await _networkService.put<Map<String, dynamic>>(
        ApiEndpoints.updateSkill.replaceAll('{id}', id),
        data: data,
      );
      return response as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to update skill: ${e.toString()}');
    }
  }

  /// Delete skill
  Future<void> deleteSkill(String id) async {
    try {
      await _networkService.delete(
        ApiEndpoints.deleteSkill.replaceAll('{id}', id),
      );
    } catch (e) {
      throw Exception('Failed to delete skill: ${e.toString()}');
    }
  }
}

/// Provider for SkillApiService
final skillApiServiceProvider = Provider<SkillApiService>((ref) {
  final networkService = ref.watch(networkServiceProvider);
  return SkillApiService(networkService);
});
