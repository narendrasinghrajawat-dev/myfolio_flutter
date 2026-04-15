import 'package:equatable/equatable.dart';

class SkillEntity extends Equatable {
  final String id;
  final String name;
  final String level;
  final String category;
  final int yearsOfExperience;
  final String? description;
  final String? icon;
  final int sortOrder;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SkillEntity({
    required this.id,
    required this.name,
    required this.level,
    required this.category,
    required this.yearsOfExperience,
    this.description,
    this.icon,
    this.sortOrder = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  SkillEntity copyWith({
    String? id,
    String? name,
    String? level,
    String? category,
    int? yearsOfExperience,
    String? description,
    String? icon,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SkillEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      level: level ?? this.level,
      category: category ?? this.category,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        level,
        category,
        yearsOfExperience,
        description,
        icon,
        sortOrder,
        createdAt,
        updatedAt,
      ];
}
