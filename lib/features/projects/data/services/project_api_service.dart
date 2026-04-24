import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/network_service.dart';
import '../../../../core/constants/api_endpoints.dart';

/// Project API service for making project-related API calls
class ProjectApiService {
  final NetworkService _networkService;

  ProjectApiService(this._networkService);

  /// Get all projects
  Future<Map<String, dynamic>> getAllProjects() async {
    try {
      final response = await _networkService.get<Map<String, dynamic>>(
        ApiEndpoints.getProjects,
      );
      return response as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to get projects: ${e.toString()}');
    }
  }

  /// Get featured projects
  Future<Map<String, dynamic>> getFeaturedProjects() async {
    try {
      final response = await _networkService.get<Map<String, dynamic>>(
        ApiEndpoints.getFeaturedProjects,
      );
      return response as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to get featured projects: ${e.toString()}');
    }
  }

  /// Search projects
  Future<Map<String, dynamic>> searchProjects(String query) async {
    try {
      final response = await _networkService.get<Map<String, dynamic>>(
        ApiEndpoints.searchProjects,
        queryParameters: {'q': query},
      );
      return response as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to search projects: ${e.toString()}');
    }
  }

  /// Get project by ID
  Future<Map<String, dynamic>> getProjectById(String id) async {
    try {
      final response = await _networkService.get<Map<String, dynamic>>(
        ApiEndpoints.getProjectById.replaceAll('{id}', id),
      );
      return response as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to get project: ${e.toString()}');
    }
  }

  /// Create project
  Future<Map<String, dynamic>> createProject(Map<String, dynamic> data) async {
    try {
      final response = await _networkService.post<Map<String, dynamic>>(
        ApiEndpoints.createProject,
        data: data,
      );
      return response as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to create project: ${e.toString()}');
    }
  }

  /// Update project
  Future<Map<String, dynamic>> updateProject(String id, Map<String, dynamic> data) async {
    try {
      final response = await _networkService.put<Map<String, dynamic>>(
        ApiEndpoints.updateProject.replaceAll('{id}', id),
        data: data,
      );
      return response as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to update project: ${e.toString()}');
    }
  }

  /// Delete project
  Future<void> deleteProject(String id) async {
    try {
      await _networkService.delete(
        ApiEndpoints.deleteProject.replaceAll('{id}', id),
      );
    } catch (e) {
      throw Exception('Failed to delete project: ${e.toString()}');
    }
  }
}

/// Provider for ProjectApiService
final projectApiServiceProvider = Provider<ProjectApiService>((ref) {
  final networkService = ref.watch(networkServiceProvider);
  return ProjectApiService(networkService);
});
