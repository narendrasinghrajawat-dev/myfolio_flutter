import '../entities/project_entity.dart';
import '../repositories/project_repository.dart';

class CreateProjectUseCase {
  final ProjectRepository _repository;

  CreateProjectUseCase(this._repository);

  Future<ProjectEntity> call(ProjectEntity project) async {
    if (project.title.isEmpty) {
      throw Exception('Project title is required');
    }
    if (project.description.isEmpty) {
      throw Exception('Project description is required');
    }
    if (project.projectUrl.isEmpty) {
      throw Exception('Project URL is required');
    }
    return await _repository.createProject(project);
  }
}
