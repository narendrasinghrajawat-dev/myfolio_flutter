import '../datasources/education_remote_datasource.dart';
import '../../domain/repositories/education_repository.dart';

class EducationRepositoryImpl implements EducationRepository {
  final EducationRemoteDataSource _remoteDataSource;

  EducationRepositoryImpl(this._remoteDataSource);

  @override
  Future<Map<String, dynamic>> getAllEducation() async {
    try {
      return await _remoteDataSource.getAllEducation();
    } catch (e) {
      throw Exception('Failed to get education: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> getEducationById(String id) async {
    try {
      return await _remoteDataSource.getEducationById(id);
    } catch (e) {
      throw Exception('Failed to get education: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> createEducation(Map<String, dynamic> data) async {
    try {
      return await _remoteDataSource.createEducation(data);
    } catch (e) {
      throw Exception('Failed to create education: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> updateEducation(String id, Map<String, dynamic> data) async {
    try {
      return await _remoteDataSource.updateEducation(id, data);
    } catch (e) {
      throw Exception('Failed to update education: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteEducation(String id) async {
    try {
      await _remoteDataSource.deleteEducation(id);
    } catch (e) {
      throw Exception('Failed to delete education: ${e.toString()}');
    }
  }
}
