import 'package:equatable/equatable.dart';

enum EducationStatus {
  initial,
  loading,
  loaded,
  error,
}

class EducationState extends Equatable {
  final EducationStatus status;
  final Map<String, dynamic>? educationList;
  final Map<String, dynamic>? selectedEducation;
  final String? errorMessage;

  const EducationState({
    required this.status,
    this.educationList,
    this.selectedEducation,
    this.errorMessage,
  });

  EducationState copyWith({
    EducationStatus? status,
    Map<String, dynamic>? educationList,
    Map<String, dynamic>? selectedEducation,
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
