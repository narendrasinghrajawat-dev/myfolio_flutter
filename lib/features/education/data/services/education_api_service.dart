import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/network_service.dart';
import '../../../../core/constants/api_endpoints.dart';

/// Education API service for making education-related API calls
class EducationApiService {
  final NetworkService _networkService;

  EducationApiService(this._networkService);

  /// Get all education entries
  Future<Map<String, dynamic>> getAllEducation() async {
    try {
      final response = await _networkService.get<Map<String, dynamic>>(
        ApiEndpoints.getEducation,
      );
      return response as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to get education: ${e.toString()}');
    }
  }

  /// Get education by ID
  Future<Map<String, dynamic>> getEducationById(String id) async {
    try {
      final response = await _networkService.get<Map<String, dynamic>>(
        ApiEndpoints.getEducationById.replaceAll('{id}', id),
      );
      return response as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to get education: ${e.toString()}');
    }
  }

  /// Create education entry
  Future<Map<String, dynamic>> createEducation(Map<String, dynamic> data) async {
    try {
      final response = await _networkService.post<Map<String, dynamic>>(
        ApiEndpoints.createEducation,
        data: data,
      );
      return response as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to create education: ${e.toString()}');
    }
  }

  /// Update education entry
  Future<Map<String, dynamic>> updateEducation(String id, Map<String, dynamic> data) async {
    try {
      final response = await _networkService.put<Map<String, dynamic>>(
        ApiEndpoints.updateEducation.replaceAll('{id}', id),
        data: data,
      );
      return response as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to update education: ${e.toString()}');
    }
  }

  /// Delete education entry
  Future<void> deleteEducation(String id) async {
    try {
      await _networkService.delete(
        ApiEndpoints.deleteEducation.replaceAll('{id}', id),
      );
    } catch (e) {
      throw Exception('Failed to delete education: ${e.toString()}');
    }
  }
}

/// Provider for EducationApiService
final educationApiServiceProvider = Provider<EducationApiService>((ref) {
  final networkService = ref.watch(networkServiceProvider);
  return EducationApiService(networkService);
});
