import '../entities/about_entity.dart';
import '../repositories/about_repository.dart';

class UpdateAboutUseCase {
  final AboutRepository _repository;

  UpdateAboutUseCase(this._repository);

  Future<AboutEntity> call(AboutEntity about) async {
    if (about.title.isEmpty) {
      throw Exception('Title is required');
    }
    if (about.description.isEmpty) {
      throw Exception('Description is required');
    }
    return await _repository.updateAbout(about);
  }
}
