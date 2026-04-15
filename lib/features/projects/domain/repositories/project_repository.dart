import '../entities/project_entity.dart';

abstract class ProjectRepository {
  Future<List<ProjectEntity>> getProjects({int page = 1, int limit = 10});
  Future<ProjectEntity?> getProjectById(String id);
  Future<ProjectEntity> createProject(ProjectEntity project);
  Future<ProjectEntity> updateProject(ProjectEntity project);
  Future<void> deleteProject(String id);
  Future<List<ProjectEntity>> getFeaturedProjects();
  Future<List<ProjectEntity>> searchProjects(String query);
  Future<List<ProjectEntity>> getProjectsByCategory(String category);
  Future<String> uploadProjectImage(String projectId, String imagePath);
  Future<void> deleteProjectImage(String projectId, String imageUrl);
}
