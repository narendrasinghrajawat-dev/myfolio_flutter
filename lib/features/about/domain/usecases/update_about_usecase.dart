import '../repositories/about_repository.dart';

class UpdateAboutUseCase {
  final AboutRepository _repository;

  UpdateAboutUseCase(this._repository);

  Future<Map<String, dynamic>> call(String id, Map<String, dynamic> data) async {
    if (data['title'] == null || data['title'].toString().isEmpty) {
      throw Exception('Title is required');
    }
    if (data['description'] == null || data['description'].toString().isEmpty) {
      throw Exception('Description is required');
    }
    return await _repository.updateAbout(id, data);
  }
}
