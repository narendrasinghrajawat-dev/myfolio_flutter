import 'package:equatable/equatable.dart';
import '../../domain/entities/education_entity.dart';

enum EducationStatus {
  initial,
  loading,
  loaded,
  error,
}

class EducationState extends Equatable {
  final EducationStatus status;
  final List<EducationEntity> educationList;
  final EducationEntity? selectedEducation;
  final String? errorMessage;

  const EducationState({
    required this.status,
    this.educationList = const [],
    this.selectedEducation,
    this.errorMessage,
  });

  EducationState copyWith({
    EducationStatus? status,
    List<EducationEntity>? educationList,
    EducationEntity? selectedEducation,
    String? errorMessage,
  }) {
    return EducationState(
      status: status ?? this.status,
      educationList: educationList ?? this.educationList,
      selectedEducation: selectedEducation ?? this.selectedEducation,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, educationList, selectedEducation, errorMessage];
}
