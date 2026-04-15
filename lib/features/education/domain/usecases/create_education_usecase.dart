import '../entities/education_entity.dart';
import '../repositories/education_repository.dart';

class CreateEducationUseCase {
  final EducationRepository _repository;

  CreateEducationUseCase(this._repository);

  Future<EducationEntity> call(EducationEntity education) async {
    if (education.institution.isEmpty) {
      throw Exception('Institution is required');
    }
    if (education.degree.isEmpty) {
      throw Exception('Degree is required');
    }
    if (education.field.isEmpty) {
      throw Exception('Field of study is required');
    }
    return await _repository.createEducation(education);
  }
}
