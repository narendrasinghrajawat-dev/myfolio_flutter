import '../models/project_model.dart';

abstract class ProjectRemoteDataSource {
  Future<List<ProjectModel>> getProjects({int page = 1, int limit = 10});
  Future<ProjectModel?> getProjectById(String id);
  Future<ProjectModel> createProject(ProjectModel project);
  Future<ProjectModel> updateProject(ProjectModel project);
  Future<void> deleteProject(String id);
  Future<List<ProjectModel>> getFeaturedProjects();
  Future<List<ProjectModel>> searchProjects(String query);
  Future<List<ProjectModel>> getProjectsByCategory(String category);
  Future<String> uploadProjectImage(String projectId, String imagePath);
  Future<void> deleteProjectImage(String projectId, String imageUrl);
}

class ProjectRemoteDataSourceImpl implements ProjectRemoteDataSource {
  final dynamic _httpClient;

  ProjectRemoteDataSourceImpl(this._httpClient);

  @override
  Future<List<ProjectModel>> getProjects({int page = 1, int limit = 10}) async {
    try {
      final response = await _httpClient.get('/projects', queryParameters: {
        'page': page.toString(),
        'limit': limit.toString(),
      });
      return (response.data['data'] as List<dynamic>)
          .map((json) => ProjectModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to get projects: ${e.toString()}');
    }
  }

  @override
  Future<ProjectModel?> getProjectById(String id) async {
    try {
      final response = await _httpClient.get('/projects/$id');
      return ProjectModel.fromJson(response.data['data']);
    } catch (e) {
      throw Exception('Failed to get project by id: ${e.toString()}');
    }
  }

  @override
  Future<ProjectModel> createProject(ProjectModel project) async {
    try {
      final response = await _httpClient.post('/projects', data: project.toJson());
      return ProjectModel.fromJson(response.data['data']);
    } catch (e) {
      throw Exception('Failed to create project: ${e.toString()}');
    }
  }

  @override
  Future<ProjectModel> updateProject(ProjectModel project) async {
    try {
      final response = await _httpClient.put('/projects/${project.id}', data: project.toJson());
      return ProjectModel.fromJson(response.data['data']);
    } catch (e) {
      throw Exception('Failed to update project: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteProject(String id) async {
    try {
      await _httpClient.delete('/projects/$id');
    } catch (e) {
      throw Exception('Failed to delete project: ${e.toString()}');
    }
  }

  @override
  Future<List<ProjectModel>> getFeaturedProjects() async {
    try {
      final response = await _httpClient.get('/projects/featured');
      return (response.data['data'] as List<dynamic>)
          .map((json) => ProjectModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to get featured projects: ${e.toString()}');
    }
  }

  @override
  Future<List<ProjectModel>> searchProjects(String query) async {
    try {
      final response = await _httpClient.get('/projects/search', queryParameters: {
        'q': query,
      });
      return (response.data['data'] as List<dynamic>)
          .map((json) => ProjectModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to search projects: ${e.toString()}');
    }
  }

  @override
  Future<List<ProjectModel>> getProjectsByCategory(String category) async {
    try {
      final response = await _httpClient.get('/projects/category/$category');
      return (response.data['data'] as List<dynamic>)
          .map((json) => ProjectModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to get projects by category: ${e.toString()}');
    }
  }

  @override
  Future<String> uploadProjectImage(String projectId, String imagePath) async {
    try {
      // TODO: Implement file upload logic
      return '';
    } catch (e) {
      throw Exception('Failed to upload project image: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteProjectImage(String projectId, String imageUrl) async {
    try {
      await _httpClient.delete('/projects/$projectId/images', data: {
        'imageUrl': imageUrl,
      });
    } catch (e) {
      throw Exception('Failed to delete project image: ${e.toString()}');
    }
  }
}
