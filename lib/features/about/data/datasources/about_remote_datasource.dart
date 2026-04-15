import '../models/about_model.dart';

abstract class AboutRemoteDataSource {
  Future<AboutModel?> getAbout();
  Future<AboutModel> updateAbout(AboutModel about);
  Future<AboutModel> updateAboutField(String field, dynamic value);
  Future<String?> uploadResume(String filePath);
  Future<void> deleteResume();
}

class AboutRemoteDataSourceImpl implements AboutRemoteDataSource {
  final dynamic _httpClient;

  AboutRemoteDataSourceImpl(this._httpClient);

  @override
  Future<AboutModel?> getAbout() async {
    try {
      final response = await _httpClient.get('/about');
      return AboutModel.fromJson(response.data['data']);
    } catch (e) {
      throw Exception('Failed to get about: ${e.toString()}');
    }
  }

  @override
  Future<AboutModel> updateAbout(AboutModel about) async {
    try {
      final response = await _httpClient.put('/about', data: about.toJson());
      return AboutModel.fromJson(response.data['data']);
    } catch (e) {
      throw Exception('Failed to update about: ${e.toString()}');
    }
  }

  @override
  Future<AboutModel> updateAboutField(String field, dynamic value) async {
    try {
      final response = await _httpClient.patch('/about/field', data: {
        'field': field,
        'value': value,
      });
      return AboutModel.fromJson(response.data['data']);
    } catch (e) {
      throw Exception('Failed to update about field: ${e.toString()}');
    }
  }

  @override
  Future<String?> uploadResume(String filePath) async {
    try {
      // TODO: Implement file upload logic
      return null;
    } catch (e) {
      throw Exception('Failed to upload resume: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteResume() async {
    try {
      await _httpClient.delete('/about/resume');
    } catch (e) {
      throw Exception('Failed to delete resume: ${e.toString()}');
    }
  }
}
