import '../entities/about_entity.dart';
import '../repositories/about_repository.dart';

class GetAboutUseCase {
  final AboutRepository _repository;

  GetAboutUseCase(this._repository);

  Future<AboutEntity?> call() async {
    return await _repository.getAbout();
  }
}
