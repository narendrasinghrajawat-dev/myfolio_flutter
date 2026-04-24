import '../repositories/project_repository.dart';

class GetProjectsUseCase {
  final ProjectRepository _repository;

  GetProjectsUseCase(this._repository);

  Future<Map<String, dynamic>> call() async {
    return await _repository.getAllProjects();
  }
}
