import '../entities/education_entity.dart';
import '../repositories/education_repository.dart';

class GetEducationUseCase {
  final EducationRepository _repository;

  GetEducationUseCase(this._repository);

  Future<List<EducationEntity>> call() async {
    return await _repository.getEducation();
  }
}
