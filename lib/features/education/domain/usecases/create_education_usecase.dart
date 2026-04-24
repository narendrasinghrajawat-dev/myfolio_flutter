import '../repositories/education_repository.dart';

class CreateEducationUseCase {
  final EducationRepository _repository;

  CreateEducationUseCase(this._repository);

  Future<Map<String, dynamic>> call(Map<String, dynamic> data) async {
    if (data['institution'] == null || data['institution'].toString().isEmpty) {
      throw Exception('Institution is required');
    }
    if (data['degree'] == null || data['degree'].toString().isEmpty) {
      throw Exception('Degree is required');
    }
    if (data['field'] == null || data['field'].toString().isEmpty) {
      throw Exception('Field of study is required');
    }
    return await _repository.createEducation(data);
  }
}
