import '../services/project_api_service.dart';

abstract class ProjectRemoteDataSource {
  Future<Map<String, dynamic>> getAllProjects();
  Future<Map<String, dynamic>> getFeaturedProjects();
  Future<Map<String, dynamic>> searchProjects(String query);
  Future<Map<String, dynamic>> getProjectById(String id);
  Future<Map<String, dynamic>> createProject(Map<String, dynamic> data);
  Future<Map<String, dynamic>> updateProject(String id, Map<String, dynamic> data);
  Future<void> deleteProject(String id);
}

class ProjectRemoteDataSourceImpl implements ProjectRemoteDataSource {
  final ProjectApiService _projectApiService;

  ProjectRemoteDataSourceImpl(this._projectApiService);

  @override
  Future<Map<String, dynamic>> getAllProjects() async {
    try {
      return await _projectApiService.getAllProjects();
    } catch (e) {
      throw Exception('Failed to get projects: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> getFeaturedProjects() async {
    try {
      return await _projectApiService.getFeaturedProjects();
    } catch (e) {
      throw Exception('Failed to get featured projects: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> searchProjects(String query) async {
    try {
      return await _projectApiService.searchProjects(query);
    } catch (e) {
      throw Exception('Failed to search projects: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> getProjectById(String id) async {
    try {
      return await _projectApiService.getProjectById(id);
    } catch (e) {
      throw Exception('Failed to get project: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> createProject(Map<String, dynamic> data) async {
    try {
      return await _projectApiService.createProject(data);
    } catch (e) {
      throw Exception('Failed to create project: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> updateProject(String id, Map<String, dynamic> data) async {
    try {
      return await _projectApiService.updateProject(id, data);
    } catch (e) {
      throw Exception('Failed to update project: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteProject(String id) async {
    try {
      await _projectApiService.deleteProject(id);
    } catch (e) {
      throw Exception('Failed to delete project: ${e.toString()}');
    }
  }
}
