abstract class AboutRepository {
  Future<Map<String, dynamic>> getAllAbout();
  Future<Map<String, dynamic>> getAboutById(String id);
  Future<Map<String, dynamic>> createAbout(Map<String, dynamic> data);
  Future<Map<String, dynamic>> updateAbout(String id, Map<String, dynamic> data);
  Future<void> deleteAbout(String id);
}
