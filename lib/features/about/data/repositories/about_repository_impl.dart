import 'package:codewithnarendra/features/about/data/models/about_model.dart';

import '../datasources/about_remote_datasource.dart';
import '../../domain/repositories/about_repository.dart';
import '../../domain/entities/about_entity.dart';

class AboutRepositoryImpl implements AboutRepository {
  final AboutRemoteDataSource _remoteDataSource;

  AboutRepositoryImpl(this._remoteDataSource);

  @override
  Future<AboutEntity?> getAbout() async {
    try {
      final aboutModel = await _remoteDataSource.getAbout();
      return aboutModel?.toEntity();
    } catch (e) {
      throw Exception('Failed to get about: ${e.toString()}');
    }
  }

  @override
  Future<AboutEntity> updateAbout(AboutEntity about) async {
    try {
      final aboutModel = AboutModel(
        id: about.id,
        title: about.title,
        description: about.description,
        resumeUrl: about.resumeUrl,
        email: about.email,
        phone: about.phone,
        location: about.location,
        website: about.website,
        linkedin: about.linkedin,
        github: about.github,
        twitter: about.twitter,
        createdAt: about.createdAt,
        updatedAt: about.updatedAt,
      );
      final updatedModel = await _remoteDataSource.updateAbout(aboutModel);
      return updatedModel.toEntity();
    } catch (e) {
      throw Exception('Failed to update about: ${e.toString()}');
    }
  }

  @override
  Future<AboutEntity> updateAboutField(String field, dynamic value) async {
    try {
      final updatedModel = await _remoteDataSource.updateAboutField(field, value);
      return updatedModel.toEntity();
    } catch (e) {
      throw Exception('Failed to update about field: ${e.toString()}');
    }
  }

  @override
  Future<String?> uploadResume(String filePath) async {
    try {
      return await _remoteDataSource.uploadResume(filePath);
    } catch (e) {
      throw Exception('Failed to upload resume: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteResume() async {
    try {
      await _remoteDataSource.deleteResume();
    } catch (e) {
      throw Exception('Failed to delete resume: ${e.toString()}');
    }
  }
}
