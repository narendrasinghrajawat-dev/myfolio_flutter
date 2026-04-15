import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_icons.dart';
import '../providers/education_provider.dart';

class EducationScreen extends ConsumerWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final educationState = ref.watch(educationStateProvider);
    final educationNotifier = ref.read(educationNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.navEducation),
        backgroundColor: AppColors.transparent,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await educationNotifier.getEducation();
        },
        child: educationState.status == EducationStatus.loading
            ? const Center(child: CircularProgressIndicator())
            : educationState.status == EducationStatus.error
                ? _buildErrorWidget(educationState.errorMessage!, educationNotifier)
                : _buildEducationList(educationState.educationList, educationNotifier),
      ),
    );
  }

  Widget _buildEducationList(educationList, educationNotifier) {
    if (educationList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              AppIcons.education,
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
              'Add your education history',
              style: TextStyle(
                fontSize: AppSizes.fontSM,
                color: AppColors.grey500,
              ),
            ),
            const SizedBox(height: AppSizes.spacingLG),
            ElevatedButton(
              onPressed: () {
                educationNotifier.getEducation();
              },
              child: const Text(AppStrings.actionRefresh),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppSizes.paddingMD),
      itemCount: educationList.length,
      itemBuilder: (context, index) {
        final education = educationList[index];
        return _buildEducationCard(education);
      },
    );
  }

  Widget _buildEducationCard(education) {
    return Card(
      elevation: AppSizes.elevationSM,
      margin: const EdgeInsets.only(bottom: AppSizes.marginMD),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMD),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              education.institution,
              style: const TextStyle(
                fontSize: AppSizes.fontLG,
                fontWeight: FontWeight.bold,
                color: AppColors.darkOnBackground,
              ),
            ),
            const SizedBox(height: AppSizes.spacingSM),
            Text(
              education.degree,
              style: const TextStyle(
                fontSize: AppSizes.fontMD,
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppSizes.spacingSM),
            Text(
              education.field,
              style: TextStyle(
                fontSize: AppSizes.fontSM,
                color: AppColors.grey600,
              ),
            ),
            const SizedBox(height: AppSizes.spacingSM),
            Row(
              children: [
                Icon(
                  AppIcons.calendar,
                  size: AppSizes.iconXS,
                  color: AppColors.grey500,
                ),
                const SizedBox(width: AppSizes.spacingXS),
                Text(
                  '${_formatDate(education.startDate)} - ${education.endDate != null ? _formatDate(education.endDate!) : AppStrings.educationPresent}',
                  style: TextStyle(
                    fontSize: AppSizes.fontXS,
                    color: AppColors.grey500,
                  ),
                ),
              ],
            ),
            if (education.gpa != null && education.gpa!.isNotEmpty) ...[
              const SizedBox(height: AppSizes.spacingSM),
              Row(
                children: [
                  Icon(
                    AppIcons.school,
                    size: AppSizes.iconXS,
                    color: AppColors.grey500,
                  ),
                  const SizedBox(width: AppSizes.spacingXS),
                  Text(
                    'GPA: ${education.gpa}',
                    style: TextStyle(
                      fontSize: AppSizes.fontXS,
                      color: AppColors.grey500,
                    ),
                  ),
                ],
              ),
            ],
            if (education.description != null && education.description!.isNotEmpty) ...[
              const SizedBox(height: AppSizes.spacingSM),
              Text(
                education.description!,
                style: TextStyle(
                  fontSize: AppSizes.fontXS,
                  color: AppColors.grey600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Widget _buildErrorWidget(String errorMessage, educationNotifier) {
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
              educationNotifier.getEducation();
            },
            child: const Text(AppStrings.actionRetry),
          ),
        ],
      ),
    );
  }
}
