import '../../domain/entities/project_entity.dart';

class ProjectModel extends ProjectEntity {
  const ProjectModel({
    required super.id,
    required super.title,
    required super.description,
    required super.technologies,
    required super.images,
    required super.projectUrl,
    required super.repositoryUrl,
    super.isFeatured = false,
    super.sortOrder = 0,
    super.client,
    super.category,
    super.status,
    required super.startDate,
    super.endDate,
    required super.createdBy,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      technologies: List<String>.from(json['technologies'] as List),
      images: List<String>.from(json['images'] as List),
      projectUrl: json['projectUrl'] as String,
      repositoryUrl: json['repositoryUrl'] as String,
      isFeatured: json['isFeatured'] as bool? ?? false,
      sortOrder: json['sortOrder'] as int? ?? 0,
      client: json['client'] as String?,
      category: json['category'] as String?,
      status: json['status'] as String?,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate'] as String) : null,
      createdBy: json['createdBy'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'technologies': technologies,
      'images': images,
      'projectUrl': projectUrl,
      'repositoryUrl': repositoryUrl,
      'isFeatured': isFeatured,
      'sortOrder': sortOrder,
      'client': client,
      'category': category,
      'status': status,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  ProjectEntity toEntity() {
    return ProjectEntity(
      id: id,
      title: title,
      description: description,
      technologies: technologies,
      images: images,
      projectUrl: projectUrl,
      repositoryUrl: repositoryUrl,
      isFeatured: isFeatured,
      sortOrder: sortOrder,
      client: client,
      category: category,
      status: status,
      startDate: startDate,
      endDate: endDate,
      createdBy: createdBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
