import 'package:codewithnarendra/features/education/data/models/education_model.dart';

import '../datasources/education_remote_datasource.dart';
import '../../domain/repositories/education_repository.dart';
import '../../domain/entities/education_entity.dart';

class EducationRepositoryImpl implements EducationRepository {
  final EducationRemoteDataSource _remoteDataSource;

  EducationRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<EducationEntity>> getEducation() async {
    try {
      final educationModels = await _remoteDataSource.getEducation();
      return educationModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to get education: ${e.toString()}');
    }
  }

  @override
  Future<EducationEntity> getEducationById(String id) async {
    try {
      final educationModel = await _remoteDataSource.getEducationById(id);
      return educationModel.toEntity();
    } catch (e) {
      throw Exception('Failed to get education by id: ${e.toString()}');
    }
  }

  @override
  Future<EducationEntity> createEducation(EducationEntity education) async {
    try {
      final educationModel = EducationModel(
        id: education.id,
        institution: education.institution,
        degree: education.degree,
        field: education.field,
        startDate: education.startDate,
        endDate: education.endDate,
        description: education.description,
        gpa: education.gpa,
        honors: education.honors,
        achievements: education.achievements,
        createdAt: education.createdAt,
        updatedAt: education.updatedAt,
      );
      final createdModel = await _remoteDataSource.createEducation(educationModel);
      return createdModel.toEntity();
    } catch (e) {
      throw Exception('Failed to create education: ${e.toString()}');
    }
  }

  @override
  Future<EducationEntity> updateEducation(EducationEntity education) async {
    try {
      final educationModel = EducationModel(
        id: education.id,
        institution: education.institution,
        degree: education.degree,
        field: education.field,
        startDate: education.startDate,
        endDate: education.endDate,
        description: education.description,
        gpa: education.gpa,
        honors: education.honors,
        achievements: education.achievements,
        createdAt: education.createdAt,
        updatedAt: education.updatedAt,
      );
      final updatedModel = await _remoteDataSource.updateEducation(educationModel);
      return updatedModel.toEntity();
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

  @override
  Future<List<EducationEntity>> getEducationByType(String type) async {
    try {
      final educationModels = await _remoteDataSource.getEducationByType(type);
      return educationModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to get education by type: ${e.toString()}');
    }
  }

  @override
  Future<List<EducationEntity>> searchEducation(String query) async {
    try {
      final educationModels = await _remoteDataSource.searchEducation(query);
      return educationModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to search education: ${e.toString()}');
    }
  }
}
