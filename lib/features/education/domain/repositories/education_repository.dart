import '../entities/education_entity.dart';

abstract class EducationRepository {
  Future<List<EducationEntity>> getEducation();
  Future<EducationEntity> getEducationById(String id);
  Future<EducationEntity> createEducation(EducationEntity education);
  Future<EducationEntity> updateEducation(EducationEntity education);
  Future<void> deleteEducation(String id);
  Future<List<EducationEntity>> getEducationByType(String type);
  Future<List<EducationEntity>> searchEducation(String query);
}
