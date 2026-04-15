import '../repositories/education_repository.dart';

class DeleteEducationUseCase {
  final EducationRepository _repository;

  DeleteEducationUseCase(this._repository);

  Future<void> call(String id) async {
    if (id.isEmpty) {
      throw Exception('Education ID is required');
    }
    await _repository.deleteEducation(id);
  }
}
