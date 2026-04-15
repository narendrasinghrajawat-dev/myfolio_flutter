import 'package:equatable/equatable.dart';

class ProjectEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final List<String> technologies;
  final List<String> images;
  final String projectUrl;
  final String repositoryUrl;
  final bool isFeatured;
  final int sortOrder;
  final String? client;
  final String? category;
  final String? status;
  final DateTime startDate;
  final DateTime? endDate;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ProjectEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.technologies,
    required this.images,
    required this.projectUrl,
    required this.repositoryUrl,
    this.isFeatured = false,
    this.sortOrder = 0,
    this.client,
    this.category,
    this.status,
    required this.startDate,
    this.endDate,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  ProjectEntity copyWith({
    String? id,
    String? title,
    String? description,
    List<String>? technologies,
    List<String>? images,
    String? projectUrl,
    String? repositoryUrl,
    bool? isFeatured,
    int? sortOrder,
    String? client,
    String? category,
    String? status,
    DateTime? startDate,
    DateTime? endDate,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProjectEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      technologies: technologies ?? this.technologies,
      images: images ?? this.images,
      projectUrl: projectUrl ?? this.projectUrl,
      repositoryUrl: repositoryUrl ?? this.repositoryUrl,
      isFeatured: isFeatured ?? this.isFeatured,
      sortOrder: sortOrder ?? this.sortOrder,
      client: client ?? this.client,
      category: category ?? this.category,
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        technologies,
        images,
        projectUrl,
        repositoryUrl,
        isFeatured,
        sortOrder,
        client,
        category,
        status,
        startDate,
        endDate,
        createdBy,
        createdAt,
        updatedAt,
      ];
}
