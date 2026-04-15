import 'package:equatable/equatable.dart';

class EducationEntity extends Equatable {
  final String id;
  final String institution;
  final String degree;
  final String field;
  final DateTime startDate;
  final DateTime? endDate;
  final String? description;
  final String? gpa;
  final String? honors;
  final String? achievements;
  final DateTime createdAt;
  final DateTime updatedAt;

  const EducationEntity({
    required this.id,
    required this.institution,
    required this.degree,
    required this.field,
    required this.startDate,
    this.endDate,
    this.description,
    this.gpa,
    this.honors,
    this.achievements,
    required this.createdAt,
    required this.updatedAt,
  });

  EducationEntity copyWith({
    String? id,
    String? institution,
    String? degree,
    String? field,
    DateTime? startDate,
    DateTime? endDate,
    String? description,
    String? gpa,
    String? honors,
    String? achievements,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return EducationEntity(
      id: id ?? this.id,
      institution: institution ?? this.institution,
      degree: degree ?? this.degree,
      field: field ?? this.field,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      description: description ?? this.description,
      gpa: gpa ?? this.gpa,
      honors: honors ?? this.honors,
      achievements: achievements ?? this.achievements,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        institution,
        degree,
        field,
        startDate,
        endDate,
        description,
        gpa,
        honors,
        achievements,
        createdAt,
        updatedAt,
      ];
}
