import '../datasources/project_remote_datasource.dart';
import '../../domain/repositories/project_repository.dart';
import '../../domain/entities/project_entity.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectRemoteDataSource _remoteDataSource;

  ProjectRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<ProjectEntity>> getProjects({int page = 1, int limit = 10}) async {
    try {
      final projectModels = await _remoteDataSource.getProjects(page: page, limit: limit);
      return projectModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to get projects: ${e.toString()}');
    }
  }

  @override
  Future<ProjectEntity?> getProjectById(String id) async {
    try {
      final projectModel = await _remoteDataSource.getProjectById(id);
      return projectModel?.toEntity();
    } catch (e) {
      throw Exception('Failed to get project by id: ${e.toString()}');
    }
  }

  @override
  Future<ProjectEntity> createProject(ProjectEntity project) async {
    try {
      final projectModel = ProjectModel(
        id: project.id,
        title: project.title,
        description: project.description,
        technologies: project.technologies,
        images: project.images,
        projectUrl: project.projectUrl,
        repositoryUrl: project.repositoryUrl,
        isFeatured: project.isFeatured,
        sortOrder: project.sortOrder,
        client: project.client,
        category: project.category,
        status: project.status,
        startDate: project.startDate,
        endDate: project.endDate,
        createdBy: project.createdBy,
        createdAt: project.createdAt,
        updatedAt: project.updatedAt,
      );
      final createdModel = await _remoteDataSource.createProject(projectModel);
      return createdModel.toEntity();
    } catch (e) {
      throw Exception('Failed to create project: ${e.toString()}');
    }
  }

  @override
  Future<ProjectEntity> updateProject(ProjectEntity project) async {
    try {
      final projectModel = ProjectModel(
        id: project.id,
        title: project.title,
        description: project.description,
        technologies: project.technologies,
        images: project.images,
        projectUrl: project.projectUrl,
        repositoryUrl: project.repositoryUrl,
        isFeatured: project.isFeatured,
        sortOrder: project.sortOrder,
        client: project.client,
        category: project.category,
        status: project.status,
        startDate: project.startDate,
        endDate: project.endDate,
        createdBy: project.createdBy,
        createdAt: project.createdAt,
        updatedAt: project.updatedAt,
      );
      final updatedModel = await _remoteDataSource.updateProject(projectModel);
      return updatedModel.toEntity();
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

  @override
  Future<List<ProjectEntity>> getFeaturedProjects() async {
    try {
      final projectModels = await _remoteDataSource.getFeaturedProjects();
      return projectModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to get featured projects: ${e.toString()}');
    }
  }

  @override
  Future<List<ProjectEntity>> searchProjects(String query) async {
    try {
      final projectModels = await _remoteDataSource.searchProjects(query);
      return projectModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to search projects: ${e.toString()}');
    }
  }

  @override
  Future<List<ProjectEntity>> getProjectsByCategory(String category) async {
    try {
      final projectModels = await _remoteDataSource.getProjectsByCategory(category);
      return projectModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to get projects by category: ${e.toString()}');
    }
  }

  @override
  Future<String> uploadProjectImage(String projectId, String imagePath) async {
    try {
      return await _remoteDataSource.uploadProjectImage(projectId, imagePath);
    } catch (e) {
      throw Exception('Failed to upload project image: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteProjectImage(String projectId, String imageUrl) async {
    try {
      await _remoteDataSource.deleteProjectImage(projectId, imageUrl);
    } catch (e) {
      throw Exception('Failed to delete project image: ${e.toString()}');
    }
  }
}
