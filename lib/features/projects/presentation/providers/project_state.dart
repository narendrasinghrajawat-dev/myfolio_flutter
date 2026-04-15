import 'package:equatable/equatable.dart';
import '../../domain/entities/project_entity.dart';

enum ProjectStatus {
  initial,
  loading,
  loaded,
  error,
}

class ProjectState extends Equatable {
  final ProjectStatus status;
  final List<ProjectEntity> projects;
  final ProjectEntity? selectedProject;
  final String? errorMessage;
  final int currentPage;
  final int totalPages;
  final bool hasMore;

  const ProjectState({
    required this.status,
    this.projects = const [],
    this.selectedProject,
    this.errorMessage,
    this.currentPage = 1,
    this.totalPages = 1,
    this.hasMore = false,
  });

  ProjectState copyWith({
    ProjectStatus? status,
    List<ProjectEntity>? projects,
    ProjectEntity? selectedProject,
    String? errorMessage,
    int? currentPage,
    int? totalPages,
    bool? hasMore,
  }) {
    return ProjectState(
      status: status ?? this.status,
      projects: projects ?? this.projects,
      selectedProject: selectedProject ?? this.selectedProject,
      errorMessage: errorMessage ?? this.errorMessage,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  List<Object?> get props => [status, projects, selectedProject, errorMessage, currentPage, totalPages, hasMore];
}
