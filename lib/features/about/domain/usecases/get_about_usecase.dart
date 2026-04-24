import '../repositories/about_repository.dart';

class GetAboutUseCase {
  final AboutRepository _repository;

  GetAboutUseCase(this._repository);

  Future<Map<String, dynamic>> call() async {
    return await _repository.getAllAbout();
  }
}
