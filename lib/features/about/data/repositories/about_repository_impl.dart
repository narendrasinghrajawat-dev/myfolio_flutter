import '../datasources/about_remote_datasource.dart';
import '../../domain/repositories/about_repository.dart';

class AboutRepositoryImpl implements AboutRepository {
  final AboutRemoteDataSource _remoteDataSource;

  AboutRepositoryImpl(this._remoteDataSource);

  @override
  Future<Map<String, dynamic>> getAllAbout() async {
    try {
      return await _remoteDataSource.getAllAbout();
    } catch (e) {
      throw Exception('Failed to get about: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> getAboutById(String id) async {
    try {
      return await _remoteDataSource.getAboutById(id);
    } catch (e) {
      throw Exception('Failed to get about: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> createAbout(Map<String, dynamic> data) async {
    try {
      return await _remoteDataSource.createAbout(data);
    } catch (e) {
      throw Exception('Failed to create about: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> updateAbout(String id, Map<String, dynamic> data) async {
    try {
      return await _remoteDataSource.updateAbout(id, data);
    } catch (e) {
      throw Exception('Failed to update about: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteAbout(String id) async {
    try {
      await _remoteDataSource.deleteAbout(id);
    } catch (e) {
      throw Exception('Failed to delete about: ${e.toString()}');
    }
  }
}
