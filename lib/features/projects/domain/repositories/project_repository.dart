abstract class ProjectRepository {
  Future<Map<String, dynamic>> getAllProjects();
  Future<Map<String, dynamic>> getFeaturedProjects();
  Future<Map<String, dynamic>> searchProjects(String query);
  Future<Map<String, dynamic>> getProjectById(String id);
  Future<Map<String, dynamic>> createProject(Map<String, dynamic> data);
  Future<Map<String, dynamic>> updateProject(String id, Map<String, dynamic> data);
  Future<void> deleteProject(String id);
}
