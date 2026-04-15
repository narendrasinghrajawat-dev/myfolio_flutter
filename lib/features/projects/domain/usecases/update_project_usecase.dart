import '../entities/project_entity.dart';
import '../repositories/project_repository.dart';

class UpdateProjectUseCase {
  final ProjectRepository _repository;

  UpdateProjectUseCase(this._repository);

  Future<ProjectEntity> call(ProjectEntity project) async {
    if (project.id.isEmpty) {
      throw Exception('Project ID is required');
    }
    if (project.title.isEmpty) {
      throw Exception('Project title is required');
    }
    if (project.description.isEmpty) {
      throw Exception('Project description is required');
    }
    return await _repository.updateProject(project);
  }
}
