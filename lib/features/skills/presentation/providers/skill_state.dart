import 'package:equatable/equatable.dart';
import '../../domain/entities/skill_entity.dart';

enum SkillStatus {
  initial,
  loading,
  loaded,
  error,
}

class SkillState extends Equatable {
  final SkillStatus status;
  final List<SkillEntity> skills;
  final SkillEntity? selectedSkill;
  final String? errorMessage;

  const SkillState({
    required this.status,
    this.skills = const [],
    this.selectedSkill,
    this.errorMessage,
  });

  SkillState copyWith({
    SkillStatus? status,
    List<SkillEntity>? skills,
    SkillEntity? selectedSkill,
    String? errorMessage,
  }) {
    return SkillState(
      status: status ?? this.status,
      skills: skills ?? this.skills,
      selectedSkill: selectedSkill ?? this.selectedSkill,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, skills, selectedSkill, errorMessage];
}
