import '../../domain/entities/skill_entity.dart';

class SkillModel extends SkillEntity {
  const SkillModel({
    required super.id,
    required super.name,
    required super.level,
    required super.category,
    required super.yearsOfExperience,
    super.description,
    super.icon,
    super.sortOrder = 0,
    required super.createdAt,
    required super.updatedAt,
  });

  factory SkillModel.fromJson(Map<String, dynamic> json) {
    return SkillModel(
      id: json['id'] as String,
      name: json['name'] as String,
      level: json['level'] as String,
      category: json['category'] as String,
      yearsOfExperience: json['yearsOfExperience'] as int,
      description: json['description'] as String?,
      icon: json['icon'] as String?,
      sortOrder: json['sortOrder'] as int? ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'level': level,
      'category': category,
      'yearsOfExperience': yearsOfExperience,
      'description': description,
      'icon': icon,
      'sortOrder': sortOrder,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  SkillEntity toEntity() {
    return SkillEntity(
      id: id,
      name: name,
      level: level,
      category: category,
      yearsOfExperience: yearsOfExperience,
      description: description,
      icon: icon,
      sortOrder: sortOrder,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
