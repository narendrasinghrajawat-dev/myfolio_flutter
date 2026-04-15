import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/project_entity.dart';
import '../../domain/usecases/get_projects_usecase.dart';
import '../../domain/usecases/create_project_usecase.dart';
import '../../domain/usecases/update_project_usecase.dart';
import '../../domain/usecases/delete_project_usecase.dart';
import 'project_state.dart';

class ProjectNotifier extends StateNotifier<ProjectState> {
  final GetProjectsUseCase _getProjectsUseCase;
  final CreateProjectUseCase _createProjectUseCase;
  final UpdateProjectUseCase _updateProjectUseCase;
  final DeleteProjectUseCase _deleteProjectUseCase;

  ProjectNotifier({
    required GetProjectsUseCase getProjectsUseCase,
    required CreateProjectUseCase createProjectUseCase,
    required UpdateProjectUseCase updateProjectUseCase,
    required DeleteProjectUseCase deleteProjectUseCase,
  }) : super(const ProjectState(status: ProjectStatus.initial)) {
    _getProjectsUseCase = getProjectsUseCase;
    _createProjectUseCase = createProjectUseCase;
    _updateProjectUseCase = updateProjectUseCase;
    _deleteProjectUseCase = deleteProjectUseCase;
  }

  Future<void> getProjects({int page = 1}) async {
    if (page == 1) {
      state = state.copyWith(status: ProjectStatus.loading);
    }
    
    try {
      final projects = await _getProjectsUseCase(page: page);
      if (page == 1) {
        state = state.copyWith(
          status: ProjectStatus.loaded,
          projects: projects,
          currentPage: page,
        );
      } else {
        state = state.copyWith(
          status: ProjectStatus.loaded,
          projects: [...state.projects, ...projects],
          currentPage: page,
        );
      }
    } catch (e) {
      state = state.copyWith(
        status: ProjectStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> createProject(ProjectEntity project) async {
    state = state.copyWith(status: ProjectStatus.loading);
    
    try {
      final createdProject = await _createProjectUseCase(project);
      state = state.copyWith(
        status: ProjectStatus.loaded,
        projects: [createdProject, ...state.projects],
      );
    } catch (e) {
      state = state.copyWith(
        status: ProjectStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> updateProject(ProjectEntity project) async {
    state = state.copyWith(status: ProjectStatus.loading);
    
    try {
      final updatedProject = await _updateProjectUseCase(project);
      final updatedProjects = state.projects.map((p) => 
        p.id == project.id ? updatedProject : p
      ).toList();
      state = state.copyWith(
        status: ProjectStatus.loaded,
        projects: updatedProjects,
      );
    } catch (e) {
      state = state.copyWith(
        status: ProjectStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> deleteProject(String id) async {
    state = state.copyWith(status: ProjectStatus.loading);
    
    try {
      await _deleteProjectUseCase(id);
      final updatedProjects = state.projects.where((p) => p.id != id).toList();
      state = state.copyWith(
        status: ProjectStatus.loaded,
        projects: updatedProjects,
      );
    } catch (e) {
      state = state.copyWith(
        status: ProjectStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  void selectProject(ProjectEntity project) {
    state = state.copyWith(selectedProject: project);
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}
