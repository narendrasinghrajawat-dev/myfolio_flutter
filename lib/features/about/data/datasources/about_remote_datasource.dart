import '../services/about_api_service.dart';

abstract class AboutRemoteDataSource {
  Future<Map<String, dynamic>> getAllAbout();
  Future<Map<String, dynamic>> getAboutById(String id);
  Future<Map<String, dynamic>> createAbout(Map<String, dynamic> data);
  Future<Map<String, dynamic>> updateAbout(String id, Map<String, dynamic> data);
  Future<void> deleteAbout(String id);
}

class AboutRemoteDataSourceImpl implements AboutRemoteDataSource {
  final AboutApiService _aboutApiService;

  AboutRemoteDataSourceImpl(this._aboutApiService);

  @override
  Future<Map<String, dynamic>> getAllAbout() async {
    try {
      return await _aboutApiService.getAllAbout();
    } catch (e) {
      throw Exception('Failed to get about: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> getAboutById(String id) async {
    try {
      return await _aboutApiService.getAboutById(id);
    } catch (e) {
      throw Exception('Failed to get about: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> createAbout(Map<String, dynamic> data) async {
    try {
      return await _aboutApiService.createAbout(data);
    } catch (e) {
      throw Exception('Failed to create about: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> updateAbout(String id, Map<String, dynamic> data) async {
    try {
      return await _aboutApiService.updateAbout(id, data);
    } catch (e) {
      throw Exception('Failed to update about: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteAbout(String id) async {
    try {
      await _aboutApiService.deleteAbout(id);
    } catch (e) {
      throw Exception('Failed to delete about: ${e.toString()}');
    }
  }
}
