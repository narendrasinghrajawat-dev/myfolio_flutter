import '../models/education_model.dart';

abstract class EducationRemoteDataSource {
  Future<List<EducationModel>> getEducation();
  Future<EducationModel> getEducationById(String id);
  Future<EducationModel> createEducation(EducationModel education);
  Future<EducationModel> updateEducation(EducationModel education);
  Future<void> deleteEducation(String id);
  Future<List<EducationModel>> getEducationByType(String type);
  Future<List<EducationModel>> searchEducation(String query);
}

class EducationRemoteDataSourceImpl implements EducationRemoteDataSource {
  final dynamic _httpClient;

  EducationRemoteDataSourceImpl(this._httpClient);

  @override
  Future<List<EducationModel>> getEducation() async {
    try {
      final response = await _httpClient.get('/education');
      return (response.data['data'] as List<dynamic>)
          .map((json) => EducationModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to get education: ${e.toString()}');
    }
  }

  @override
  Future<EducationModel> getEducationById(String id) async {
    try {
      final response = await _httpClient.get('/education/$id');
      return EducationModel.fromJson(response.data['data']);
    } catch (e) {
      throw Exception('Failed to get education by id: ${e.toString()}');
    }
  }

  @override
  Future<EducationModel> createEducation(EducationModel education) async {
    try {
      final response = await _httpClient.post('/education', data: education.toJson());
      return EducationModel.fromJson(response.data['data']);
    } catch (e) {
      throw Exception('Failed to create education: ${e.toString()}');
    }
  }

  @override
  Future<EducationModel> updateEducation(EducationModel education) async {
    try {
      final response = await _httpClient.put('/education/${education.id}', data: education.toJson());
      return EducationModel.fromJson(response.data['data']);
    } catch (e) {
      throw Exception('Failed to update education: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteEducation(String id) async {
    try {
      await _httpClient.delete('/education/$id');
    } catch (e) {
      throw Exception('Failed to delete education: ${e.toString()}');
    }
  }

  @override
  Future<List<EducationModel>> getEducationByType(String type) async {
    try {
      final response = await _httpClient.get('/education/type/$type');
      return (response.data['data'] as List<dynamic>)
          .map((json) => EducationModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to get education by type: ${e.toString()}');
    }
  }

  @override
  Future<List<EducationModel>> searchEducation(String query) async {
    try {
      final response = await _httpClient.get('/education/search', queryParameters: {
        'q': query,
      });
      return (response.data['data'] as List<dynamic>)
          .map((json) => EducationModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to search education: ${e.toString()}');
    }
  }
}
