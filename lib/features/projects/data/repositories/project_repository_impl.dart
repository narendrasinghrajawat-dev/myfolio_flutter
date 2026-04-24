import '../datasources/project_remote_datasource.dart';
import '../../domain/repositories/project_repository.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectRemoteDataSource _remoteDataSource;

  ProjectRepositoryImpl(this._remoteDataSource);

  @override
  Future<Map<String, dynamic>> getAllProjects() async {
    try {
      return await _remoteDataSource.getAllProjects();
    } catch (e) {
      throw Exception('Failed to get projects: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> getFeaturedProjects() async {
    try {
      return await _remoteDataSource.getFeaturedProjects();
    } catch (e) {
      throw Exception('Failed to get featured projects: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> searchProjects(String query) async {
    try {
      return await _remoteDataSource.searchProjects(query);
    } catch (e) {
      throw Exception('Failed to search projects: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> getProjectById(String id) async {
    try {
      return await _remoteDataSource.getProjectById(id);
    } catch (e) {
      throw Exception('Failed to get project: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> createProject(Map<String, dynamic> data) async {
    try {
      return await _remoteDataSource.createProject(data);
    } catch (e) {
      throw Exception('Failed to create project: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> updateProject(String id, Map<String, dynamic> data) async {
    try {
      return await _remoteDataSource.updateProject(id, data);
    } catch (e) {
      throw Exception('Failed to update project: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteProject(String id) async {
    try {
      await _remoteDataSource.deleteProject(id);
    } catch (e) {
      throw Exception('Failed to delete project: ${e.toString()}');
    }
  }
}
