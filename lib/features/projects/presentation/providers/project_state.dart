import 'package:equatable/equatable.dart';

enum ProjectStatus {
  initial,
  loading,
  loaded,
  error,
}

class ProjectState extends Equatable {
  final ProjectStatus status;
  final Map<String, dynamic>? projects;
  final Map<String, dynamic>? selectedProject;
  final String? errorMessage;

  const ProjectState({
    required this.status,
    this.projects,
    this.selectedProject,
    this.errorMessage,
  });

  ProjectState copyWith({
    ProjectStatus? status,
    Map<String, dynamic>? projects,
    Map<String, dynamic>? selectedProject,
    String? errorMessage,
  }) {
    return ProjectState(
      status: status ?? this.status,
      projects: projects ?? this.projects,
      selectedProject: selectedProject ?? this.selectedProject,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, projects, selectedProject, errorMessage];
}
