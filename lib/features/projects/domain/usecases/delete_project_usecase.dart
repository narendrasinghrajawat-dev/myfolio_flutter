import '../repositories/project_repository.dart';

class DeleteProjectUseCase {
  final ProjectRepository _repository;

  DeleteProjectUseCase(this._repository);

  Future<void> call(String id) async {
    if (id.isEmpty) {
      throw Exception('Project ID is required');
    }
    await _repository.deleteProject(id);
  }
}
