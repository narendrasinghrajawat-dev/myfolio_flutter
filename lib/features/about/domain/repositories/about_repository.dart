import '../entities/about_entity.dart';

abstract class AboutRepository {
  Future<AboutEntity?> getAbout();
  Future<AboutEntity> updateAbout(AboutEntity about);
  Future<AboutEntity> updateAboutField(String field, dynamic value);
  Future<String?> uploadResume(String filePath);
  Future<void> deleteResume();
}
