import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class FirebaseStorageService {
  final FirebaseStorage _storage;

  FirebaseStorageService(this._storage);

  // Upload file to Firebase Storage
  Future<String> uploadFile({
    required File file,
    required String path,
    Map<String, String>? metadata,
  }) async {
    try {
      final ref = _storage.ref().child(path);
      final uploadTask = await ref.putFile(
        file,
        metadata: metadata ?? const SettableMetadata(
          contentType: _getContentType(file.path),
        ),
      );

      final snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      throw Exception('Failed to upload file: ${e.toString()}');
    }
  }

  // Upload multiple files
  Future<List<String>> uploadMultipleFiles({
    required List<File> files,
    required String basePath,
    Map<String, String>? metadata,
  }) async {
    final urls = <String>[];
    
    for (int i = 0; i < files.length; i++) {
      final url = await uploadFile(
        file: files[i],
        path: '$basePath/${files[i].path.split('/').last}',
        metadata: metadata,
      );
      urls.add(url);
    }
    
    return urls;
  }

  // Delete file from Firebase Storage
  Future<void> deleteFile(String path) async {
    try {
      final ref = _storage.ref().child(path);
      await ref.delete();
    } catch (e) {
      throw Exception('Failed to delete file: ${e.toString()}');
    }
  }

  // Get file download URL
  Future<String?> getFileUrl(String path) async {
    try {
      final ref = _storage.ref().child(path);
      return await ref.getDownloadURL();
    } catch (e) {
      throw Exception('Failed to get file URL: ${e.toString()}');
    }
  }

  // List files in a directory
  Future<List<String>> listFiles(String path) async {
    try {
      final ref = _storage.ref().child(path);
      final result = await ref.listAll();
      
      return result.items
          .where((item) => item.name.isNotEmpty)
          .map((item) => item.fullPath)
          .toList();
    } catch (e) {
      throw Exception('Failed to list files: ${e.toString()}');
    }
  }

  // Get content type based on file extension
  String _getContentType(String filePath) {
    final extension = filePath.toLowerCase().split('.').last;
    
    switch (extension) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      case 'svg':
        return 'image/svg+xml';
      case 'pdf':
        return 'application/pdf';
      case 'doc':
      case 'docx':
        return 'application/msword';
      case 'txt':
        return 'text/plain';
      default:
        return 'application/octet-stream';
    }
  }

  // Upload image with compression
  Future<String> uploadImage({
    required File imageFile,
    required String path,
    int quality = 80,
  }) async {
    try {
      final ref = _storage.ref().child(path);
      final uploadTask = await ref.putFile(
        imageFile,
        SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {
            'quality': quality.toString(),
          },
        ),
      );

      final snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      throw Exception('Failed to upload image: ${e.toString()}');
    }
  }

  // Delete multiple files
  Future<void> deleteMultipleFiles(List<String> paths) async {
    for (final path in paths) {
      try {
        await deleteFile(path);
      } catch (e) {
        // Continue with other files even if one fails
        print('Failed to delete $path: ${e.toString()}');
      }
    }
  }
}
