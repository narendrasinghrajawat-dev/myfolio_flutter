import 'package:codewithnarendra/core/constants/app_colors.dart';
import 'package:codewithnarendra/core/constants/app_icons.dart';
import 'package:codewithnarendra/core/constants/app_sizes.dart';
import 'package:codewithnarendra/core/constants/app_strings.dart';
import 'package:codewithnarendra/features/projects/presentation/providers/project_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/project_provider.dart';

class ProjectScreen extends ConsumerWidget {
  const ProjectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectState = ref.watch(projectStateProvider);
    final projectNotifier = ref.read(projectNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.navProjects),
        backgroundColor: AppColors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(AppIcons.add),
            onPressed: () {
              // TODO: Navigate to add project screen
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await projectNotifier.getProjects();
        },
        child: projectState.status == ProjectStatus.loading
            ? const Center(child: CircularProgressIndicator())
            : projectState.status == ProjectStatus.error
                ? _buildErrorWidget(projectState.errorMessage!, projectNotifier)
                : _buildProjectList(projectState.projects, projectNotifier),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to add project screen
        },
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        child: const Icon(AppIcons.add),
      ),
    );
  }

  Widget _buildProjectList(projects, projectNotifier) {
    if (projects.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              AppIcons.projects,
              size: AppSizes.iconXXXXL,
              color: AppColors.grey400,
            ),
            const SizedBox(height: AppSizes.spacingMD),
            const Text(
              AppStrings.statusEmpty,
              style: TextStyle(
                fontSize: AppSizes.fontMD,
                color: AppColors.grey600,
              ),
            ),
            const SizedBox(height: AppSizes.spacingSM),
            const Text(
              'Add your first project to showcase',
              style: TextStyle(
                fontSize: AppSizes.fontSM,
                color: AppColors.grey500,
              ),
            ),
            const SizedBox(height: AppSizes.spacingLG),
            ElevatedButton(
              onPressed: () {
                projectNotifier.getProjects();
              },
              child: const Text(AppStrings.actionRefresh),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppSizes.paddingMD),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        final project = projects[index];
        return _buildProjectCard(project);
      },
    );
  }

  Widget _buildProjectCard(project) {
    return Card(
      elevation: AppSizes.elevationSM,
      margin: const EdgeInsets.only(bottom: AppSizes.marginMD),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMD),
      ),
      child: InkWell(
        onTap: () {
          // TODO: Navigate to project detail screen
        },
        borderRadius: BorderRadius.circular(AppSizes.radiusMD),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.paddingMD),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (project.isFeatured)
                    Icon(
                      AppIcons.star,
                      size: AppSizes.iconSM,
                      color: AppColors.warning,
                    ),
                  Expanded(
                    child: Text(
                      project.title,
                      style: const TextStyle(
                        fontSize: AppSizes.fontLG,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkOnBackground,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.spacingSM),
              Text(
                project.description,
                style: TextStyle(
                  fontSize: AppSizes.fontSM,
                  color: AppColors.grey600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSizes.spacingMD),
              if (project.technologies.isNotEmpty)
                Wrap(
                  spacing: AppSizes.spacingXS,
                  runSpacing: AppSizes.spacingXS,
                  children: project.technologies
                      .take(3)
                      .map((tech) => Chip(
                            label: Text(tech),
                            backgroundColor: AppColors.primaryLight,
                            labelStyle: TextStyle(
                              fontSize: AppSizes.fontXS,
                              color: AppColors.white,
                            ),
                          ))
                      .toList(),
                ),
              const SizedBox(height: AppSizes.spacingMD),
              Row(
                children: [
                  Icon(
                    AppIcons.link,
                    color: AppColors.primary,
                    size: AppSizes.iconSM,
                  ),
                  const SizedBox(width: AppSizes.spacingXS),
                  Expanded(
                    child: Text(
                      'View Project',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: AppSizes.fontSM,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSizes.spacingSM),
                  IconButton(
                    icon: const Icon(AppIcons.github),
                    color: AppColors.darkOnBackground,
                    onPressed: () {
                      // TODO: Open repository URL
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorWidget(String errorMessage, projectNotifier) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            AppIcons.error,
            size: AppSizes.iconXXXXL,
            color: AppColors.error,
          ),
          const SizedBox(height: AppSizes.spacingMD),
          Text(
            errorMessage,
            style: const TextStyle(
              fontSize: AppSizes.fontMD,
              color: AppColors.error,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSizes.spacingMD),
          ElevatedButton(
            onPressed: () {
              projectNotifier.getProjects();
            },
            child: const Text(AppStrings.actionRetry),
          ),
        ],
      ),
    );
  }
}
