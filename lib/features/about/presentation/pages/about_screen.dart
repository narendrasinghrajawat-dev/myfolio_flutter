import 'package:codewithnarendra/core/constants/app_colors.dart';
import 'package:codewithnarendra/core/constants/app_icons.dart';
import 'package:codewithnarendra/core/constants/app_sizes.dart';
import 'package:codewithnarendra/core/constants/app_strings.dart';
import 'package:codewithnarendra/features/about/presentation/providers/about_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/about_provider.dart';

class AboutScreen extends ConsumerWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aboutState = ref.watch(aboutStateProvider);
    final aboutNotifier = ref.read(aboutNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.navAbout),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await aboutNotifier.getAbout();
        },
        child: aboutState.status == AboutStatus.loading
            ? const Center(child: CircularProgressIndicator())
            : aboutState.status == AboutStatus.error
                ? _buildErrorWidget(aboutState.errorMessage!, aboutNotifier)
                : aboutState.about != null
                    ? _buildAboutContent(aboutState.about!)
                    : _buildEmptyWidget(aboutNotifier),
      ),
    );
  }

  Widget _buildAboutContent(about) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.paddingLG),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            about.title,
            style: const TextStyle(
              fontSize: AppSizes.fontXXL,
              fontWeight: FontWeight.bold,
              color: AppColors.darkOnBackground,
            ),
          ),
          const SizedBox(height: AppSizes.spacingLG),
          Text(
            about.description,
            style: TextStyle(
              fontSize: AppSizes.fontMD,
              height: 1.5,
              color: AppColors.grey600,
            ),
          ),
          const SizedBox(height: AppSizes.spacingLG),
          if (about.resumeUrl != null) _buildResumeButton(about.resumeUrl!),
          const SizedBox(height: AppSizes.spacingLG),
          _buildContactInfo(about),
          const SizedBox(height: AppSizes.spacingLG),
          _buildSocialLinks(about),
        ],
      ),
    );
  }

  Widget _buildResumeButton(String resumeUrl) {
    return ElevatedButton.icon(
      onPressed: () {
        // TODO: Open resume URL
      },
      icon: const Icon(AppIcons.document),
      label: const Text(AppStrings.portfolioDownloadResume),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.paddingLG,
          vertical: AppSizes.paddingMD,
        ),
      ),
    );
  }

  Widget _buildContactInfo(about) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contact Information',
          style: TextStyle(
            fontSize: AppSizes.fontLG,
            fontWeight: FontWeight.w600,
            color: AppColors.darkOnBackground,
          ),
        ),
        const SizedBox(height: AppSizes.spacingMD),
        if (about.email != null)
          _buildContactItem(AppIcons.email, about.email!),
        if (about.phone != null)
          _buildContactItem(AppIcons.phone, about.phone!),
        if (about.location != null)
          _buildContactItem(AppIcons.location, about.location!),
        if (about.website != null)
          _buildContactItem(AppIcons.website, about.website!),
      ],
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.paddingSM),
      child: Row(
        children: [
          Icon(icon, size: AppSizes.iconSM, color: AppColors.primary),
          const SizedBox(width: AppSizes.spacingSM),
          Text(
            text,
            style: TextStyle(
              fontSize: AppSizes.fontSM,
              color: AppColors.grey600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialLinks(about) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Social Links',
          style: TextStyle(
            fontSize: AppSizes.fontLG,
            fontWeight: FontWeight.w600,
            color: AppColors.darkOnBackground,
          ),
        ),
        const SizedBox(height: AppSizes.spacingMD),
        Wrap(
          spacing: AppSizes.spacingMD,
          children: [
            if (about.linkedin != null)
              _buildSocialButton(AppIcons.linkedin, about.linkedin!),
            if (about.github != null)
              _buildSocialButton(AppIcons.github, about.github!),
            if (about.twitter != null)
              _buildSocialButton(AppIcons.twitter, about.twitter!),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton(IconData icon, String url) {
    return IconButton(
      onPressed: () {
        // TODO: Open social URL
      },
      icon: Icon(icon),
      style: IconButton.styleFrom(
        backgroundColor: AppColors.grey200,
        foregroundColor: AppColors.darkOnBackground,
      ),
    );
  }

  Widget _buildErrorWidget(String errorMessage, aboutNotifier) {
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
              aboutNotifier.getAbout();
            },
            child: const Text(AppStrings.actionRetry),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyWidget(aboutNotifier) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            AppIcons.about,
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
            'Add your about information',
            style: TextStyle(
              fontSize: AppSizes.fontSM,
              color: AppColors.grey500,
            ),
          ),
          const SizedBox(height: AppSizes.spacingLG),
          ElevatedButton(
            onPressed: () {
              aboutNotifier.getAbout();
            },
            child: const Text(AppStrings.actionRefresh),
          ),
        ],
      ),
    );
  }
}
