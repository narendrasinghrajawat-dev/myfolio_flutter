import '../repositories/project_repository.dart';

class CreateProjectUseCase {
  final ProjectRepository _repository;

  CreateProjectUseCase(this._repository);

  Future<Map<String, dynamic>> call(Map<String, dynamic> data) async {
    if (data['title'] == null || data['title'].toString().isEmpty) {
      throw Exception('Project title is required');
    }
    if (data['description'] == null || data['description'].toString().isEmpty) {
      throw Exception('Project description is required');
    }
    return await _repository.createProject(data);
  }
}
