import 'package:codewithnarendra/core/services/localization_service.dart';
import 'package:codewithnarendra/core/theme/app_theme.dart';
import 'package:codewithnarendra/core/constants/app_sizes.dart';
import 'package:codewithnarendra/features/portfolio/domain/project_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/services/theme_service.dart';
import '../portfolio_notifier.dart';


class PortfolioPage extends ConsumerWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeStateProvider);
    final portfolioState = ref.watch(portfolioStateProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(context.portfolio),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              ref.read(themeStateProvider.notifier).toggleTheme();
            },
          ),
          PopupMenuButton<String>(
            onSelected: (language) {
              final lang = language == 'hi' ? AppLanguage.hi : AppLanguage.en;
              ref.read(localizationNotifierProvider).setLanguage(lang);
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'en',
                child: Text('English'),
              ),
              PopupMenuItem(
                value: 'hi',
                child: Text('हिंदी'),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: themeState.isDarkMode 
            ? AppTheme.darkTheme.scaffoldBackgroundColor 
            : AppTheme.lightTheme.scaffoldBackgroundColor,
      body: portfolioState.isLoading 
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : portfolioState.error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Error: ${portfolioState.error}',
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          ref.read(portfolioNotifierProvider.notifier).loadProjects();
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : _buildPortfolioContent(context, ref, portfolioState.projects),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(portfolioNotifierProvider.notifier).loadProjects();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildPortfolioContent(
    BuildContext context,
    WidgetRef ref,
    List<ProjectEntity> projects,
  ) {
    if (projects.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.work_outline,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'No projects yet',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Your portfolio will appear here once you add projects.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        ref.read(portfolioNotifierProvider.notifier).loadProjects();
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.spacingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.projects,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSizes.spacingMD),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: AppSizes.spacingMD,
                mainAxisSpacing: AppSizes.spacingMD,
                childAspectRatio: 1.0,
              ),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index];
                return _buildProjectCard(context, ref, project);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectCard(
    BuildContext context,
    WidgetRef ref,
    ProjectEntity project,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMD),
      ),
      child: InkWell(
        onTap: () {
          // Navigate to project details
        },
        borderRadius: BorderRadius.circular(AppSizes.radiusMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (project.hasImages)
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppSizes.radiusMD),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: project.images.first,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: (context, url) => Container(
                      color: Colors.grey[300],
                      child: Icon(
                        Icons.image,
                        size: 48,
                        color: Colors.grey[600],
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[300],
                      child: Icon(
                        Icons.broken_image,
                        size: 48,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ),
              ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.spacingMD),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.title,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSizes.spacingSM),
                    Text(
                      project.description,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Wrap(
                      spacing: AppSizes.spacingSM,
                      runSpacing: AppSizes.spacingSM,
                      children: project.technologies
                          .take(3)
                          .map((tech) => Chip(
                                label: Text(
                                  tech,
                                  style: const TextStyle(fontSize: 10),
                                ),
                                backgroundColor: Colors.blue.shade100,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
