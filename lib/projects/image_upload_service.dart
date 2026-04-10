import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';
import 'project_notifier.dart';

class ImageUploadService {
  final FirebaseStorage _storage;
  final Dio _dio;
  
  ImageUploadService(this._storage, this._dio);

  Future<String> uploadProjectImage(String projectId, String imagePath) async {
    try {
      final file = File(imagePath);
      final fileName = 'project_$projectId.jpg';
      final ref = _storage.ref().child('projects/$projectId/$fileName');
      
      final uploadTask = ref.putFile(file);
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  Future<void> deleteProjectImage(String projectId, String imageUrl) async {
    try {
      final ref = FirebaseStorage.instance.refFromURL(imageUrl);
      await ref.delete();
    } catch (e) {
      throw Exception('Failed to delete image: $e');
    }
  }
}
