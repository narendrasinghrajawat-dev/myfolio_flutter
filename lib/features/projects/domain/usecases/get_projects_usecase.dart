import '../entities/project_entity.dart';
import '../repositories/project_repository.dart';

class GetProjectsUseCase {
  final ProjectRepository _repository;

  GetProjectsUseCase(this._repository);

  Future<List<ProjectEntity>> call({int page = 1, int limit = 10}) async {
    return await _repository.getProjects(page: page, limit: limit);
  }
}
