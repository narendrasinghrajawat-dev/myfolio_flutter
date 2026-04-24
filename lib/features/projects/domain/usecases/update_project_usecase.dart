import '../repositories/project_repository.dart';

class UpdateProjectUseCase {
  final ProjectRepository _repository;

  UpdateProjectUseCase(this._repository);

  Future<Map<String, dynamic>> call(String id, Map<String, dynamic> data) async {
    if (id.isEmpty) {
      throw Exception('Project ID is required');
    }
    if (data['title'] == null || data['title'].toString().isEmpty) {
      throw Exception('Project title is required');
    }
    if (data['description'] == null || data['description'].toString().isEmpty) {
      throw Exception('Project description is required');
    }
    return await _repository.updateProject(id, data);
  }
}
