import '../repositories/education_repository.dart';

class UpdateEducationUseCase {
  final EducationRepository _repository;

  UpdateEducationUseCase(this._repository);

  Future<Map<String, dynamic>> call(String id, Map<String, dynamic> data) async {
    if (id.isEmpty) {
      throw Exception('Education ID is required');
    }
    if (data['institution'] == null || data['institution'].toString().isEmpty) {
      throw Exception('Institution is required');
    }
    if (data['degree'] == null || data['degree'].toString().isEmpty) {
      throw Exception('Degree is required');
    }
    if (data['field'] == null || data['field'].toString().isEmpty) {
      throw Exception('Field of study is required');
    }
    return await _repository.updateEducation(id, data);
  }
}
