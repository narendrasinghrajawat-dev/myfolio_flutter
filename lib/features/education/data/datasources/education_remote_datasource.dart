import '../services/education_api_service.dart';

abstract class EducationRemoteDataSource {
  Future<Map<String, dynamic>> getAllEducation();
  Future<Map<String, dynamic>> getEducationById(String id);
  Future<Map<String, dynamic>> createEducation(Map<String, dynamic> data);
  Future<Map<String, dynamic>> updateEducation(String id, Map<String, dynamic> data);
  Future<void> deleteEducation(String id);
}

class EducationRemoteDataSourceImpl implements EducationRemoteDataSource {
  final EducationApiService _educationApiService;

  EducationRemoteDataSourceImpl(this._educationApiService);

  @override
  Future<Map<String, dynamic>> getAllEducation() async {
    try {
      return await _educationApiService.getAllEducation();
    } catch (e) {
      throw Exception('Failed to get education: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> getEducationById(String id) async {
    try {
      return await _educationApiService.getEducationById(id);
    } catch (e) {
      throw Exception('Failed to get education: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> createEducation(Map<String, dynamic> data) async {
    try {
      return await _educationApiService.createEducation(data);
    } catch (e) {
      throw Exception('Failed to create education: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> updateEducation(String id, Map<String, dynamic> data) async {
    try {
      return await _educationApiService.updateEducation(id, data);
    } catch (e) {
      throw Exception('Failed to update education: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteEducation(String id) async {
    try {
      await _educationApiService.deleteEducation(id);
    } catch (e) {
      throw Exception('Failed to delete education: ${e.toString()}');
    }
  }
}
