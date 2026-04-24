abstract class EducationRepository {
  Future<Map<String, dynamic>> getAllEducation();
  Future<Map<String, dynamic>> getEducationById(String id);
  Future<Map<String, dynamic>> createEducation(Map<String, dynamic> data);
  Future<Map<String, dynamic>> updateEducation(String id, Map<String, dynamic> data);
  Future<void> deleteEducation(String id);
}
