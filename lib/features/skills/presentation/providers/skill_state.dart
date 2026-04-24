import 'package:equatable/equatable.dart';

enum SkillStatus {
  initial,
  loading,
  loaded,
  error,
}

class SkillState extends Equatable {
  final SkillStatus status;
  final Map<String, dynamic>? skills;
  final Map<String, dynamic>? selectedSkill;
  final String? errorMessage;

  const SkillState({
    required this.status,
    this.skills,
    this.selectedSkill,
    this.errorMessage,
  });

  SkillState copyWith({
    SkillStatus? status,
    Map<String, dynamic>? skills,
    Map<String, dynamic>? selectedSkill,
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
