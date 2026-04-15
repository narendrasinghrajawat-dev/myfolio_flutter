import '../../domain/entities/education_entity.dart';

class EducationModel extends EducationEntity {
  const EducationModel({
    required super.id,
    required super.institution,
    required super.degree,
    required super.field,
    required super.startDate,
    super.endDate,
    super.description,
    super.gpa,
    super.honors,
    super.achievements,
    required super.createdAt,
    required super.updatedAt,
  });

  factory EducationModel.fromJson(Map<String, dynamic> json) {
    return EducationModel(
      id: json['id'] as String,
      institution: json['institution'] as String,
      degree: json['degree'] as String,
      field: json['field'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate'] as String) : null,
      description: json['description'] as String?,
      gpa: json['gpa'] as String?,
      honors: json['honors'] as String?,
      achievements: json['achievements'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'institution': institution,
      'degree': degree,
      'field': field,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'description': description,
      'gpa': gpa,
      'honors': honors,
      'achievements': achievements,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  EducationEntity toEntity() {
    return EducationEntity(
      id: id,
      institution: institution,
      degree: degree,
      field: field,
      startDate: startDate,
      endDate: endDate,
      description: description,
      gpa: gpa,
      honors: honors,
      achievements: achievements,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
