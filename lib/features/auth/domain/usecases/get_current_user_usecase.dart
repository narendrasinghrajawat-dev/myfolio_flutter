import '../repositories/auth_repository.dart';

class GetCurrentUserUseCase {
  final AuthRepository _repository;

  GetCurrentUserUseCase(this._repository);

  Future<Map<String, dynamic>> call() async {
    return await _repository.getCurrentUser();
  }
}
