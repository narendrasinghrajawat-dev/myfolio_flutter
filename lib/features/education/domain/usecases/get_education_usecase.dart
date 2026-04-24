import '../repositories/education_repository.dart';

class GetEducationUseCase {
  final EducationRepository _repository;

  GetEducationUseCase(this._repository);

  Future<Map<String, dynamic>> call() async {
    return await _repository.getAllEducation();
  }
}
