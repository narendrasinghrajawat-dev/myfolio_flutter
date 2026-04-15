import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/responsive_builder.dart';
import '../../../../core/widgets/responsive_container.dart';
import '../../../../core/widgets/responsive_row.dart';
import '../../../../core/widgets/responsive_column.dart';
import '../providers/admin_navigation_provider.dart';

class AdminDashboard extends ConsumerWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationState = ref.watch(adminNavigationProvider);
    
    return Scaffold(
      backgroundColor: AppColors.background,
      body: ResponsiveBuilder(
        mobile: _buildMobileLayout(context, navigationState),
        tablet: _buildTabletLayout(context, navigationState),
        desktop: _buildDesktopLayout(context, navigationState),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, AdminNavigationState navigationState) {
    return Column(
      children: [
        _buildMobileAppBar(context, navigationState),
        Expanded(
          child: _buildMainContent(navigationState),
        ),
      ],
    );
  }

  Widget _buildTabletLayout(BuildContext context, AdminNavigationState navigationState) {
    return Row(
      children: [
        if (navigationState.isSidebarExpanded)
          SizedBox(
            width: 250,
            child: _buildSidebar(navigationState),
          ),
        Expanded(
          child: _buildMainContent(navigationState),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context, AdminNavigationState navigationState) {
    return Row(
      children: [
        if (navigationState.isSidebarExpanded)
          SizedBox(
            width: 280,
            child: _buildSidebar(navigationState),
          ),
        Expanded(
          child: _buildMainContent(navigationState),
        ),
      ],
    );
  }

  Widget _buildMobileAppBar(BuildContext context, AdminNavigationState navigationState) {
    return ResponsiveContainer(
      mobilePadding: const EdgeInsets.all(AppSizes.paddingSM),
      desktopPadding: const EdgeInsets.all(AppSizes.paddingMD),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(AppIcons.menu),
            onPressed: () {
              ref.read(adminNavigationProvider.notifier).toggleSidebar();
            },
          ),
          const SizedBox(width: AppSizes.spacingMD),
          Expanded(
            child: AppText.medium(
              'Admin Panel',
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            icon: const Icon(AppIcons.settings),
            onPressed: () {
              // TODO: Settings
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar(AdminNavigationState navigationState) {
    return ResponsiveContainer(
      mobileDecoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.grey300,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ResponsiveColumn(
        children: [
          _buildSidebarHeader(),
          const SizedBox(height: AppSizes.spacingMD),
          _buildSidebarMenu(navigationState),
        ],
      ),
    );
  }

  Widget _buildSidebarHeader() {
    return ResponsiveContainer(
      mobilePadding: const EdgeInsets.all(AppSizes.paddingMD),
      desktopPadding: const EdgeInsets.all(AppSizes.paddingLG),
      child: ResponsiveRow(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.primary,
            child: AppText.medium(
              'A',
              color: AppColors.onPrimary,
            ),
          ),
          const SizedBox(width: AppSizes.spacingMD),
          Expanded(
            child: ResponsiveColumn(
              children: [
                AppText.medium('Admin Dashboard'),
                AppText.small(
                  'Manage your portfolio content',
                  color: AppColors.grey600,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarMenu(AdminNavigationState navigationState) {
    return ResponsiveColumn(
      children: [
        _buildSidebarMenuItem(
          icon: AppIcons.home,
          title: 'Dashboard',
          section: AdminSection.dashboard,
          navigationState: navigationState,
        ),
        _buildSidebarMenuItem(
          icon: AppIcons.person,
          title: 'About',
          section: AdminSection.about,
          navigationState: navigationState,
        ),
        _buildSidebarMenuItem(
          icon: AppIcons.psychology,
          title: 'Skills',
          section: AdminSection.skills,
          navigationState: navigationState,
        ),
        _buildSidebarMenuItem(
          icon: AppIcons.school,
          title: 'Education',
          section: AdminSection.education,
          navigationState: navigationState,
        ),
        _buildSidebarMenuItem(
          icon: AppIcons.email,
          title: 'Contact',
          section: AdminSection.contact,
          navigationState: navigationState,
        ),
      ],
    );
  }

  Widget _buildSidebarMenuItem({
    required IconData icon,
    required String title,
    required AdminSection section,
    required AdminNavigationState navigationState,
  }) {
    final isSelected = navigationState.currentSection == section;
    
    return ResponsiveContainer(
      mobilePadding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingSM, vertical: AppSizes.spacingXS),
      desktopPadding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMD, vertical: AppSizes.spacingSM),
      child: Material(
        color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(AppSizes.radiusMD),
        child: InkWell(
          onTap: () {
            final notifier = ref.read(adminNavigationProvider.notifier);
            notifier.navigateToSection(section);
          },
          borderRadius: BorderRadius.circular(AppSizes.radiusMD),
          child: ResponsiveContainer(
            mobilePadding: const EdgeInsets.all(AppSizes.paddingMD),
            desktopPadding: const EdgeInsets.all(AppSizes.paddingLG),
            child: ResponsiveRow(
              children: [
                Icon(
                  icon,
                  color: isSelected ? AppColors.primary : AppColors.grey600,
                  size: AppSizes.iconMD,
                ),
                const SizedBox(width: AppSizes.spacingMD),
                Expanded(
                  child: AppText.medium(
                    title,
                    color: isSelected ? AppColors.primary : AppColors.onSurface,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(AdminNavigationState navigationState) {
    return ResponsiveContainer(
      mobilePadding: const EdgeInsets.all(AppSizes.paddingMD),
      desktopPadding: const EdgeInsets.all(AppSizes.paddingXL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildContentHeader(navigationState),
          const SizedBox(height: AppSizes.spacingLG),
          Expanded(
            child: _buildContentArea(navigationState),
          ),
        ],
      ),
    );
  }

  Widget _buildContentHeader(AdminNavigationState navigationState) {
    return ResponsiveContainer(
      mobileDecoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.grey300)),
      ),
      desktopDecoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.grey300)),
      ),
      child: ResponsiveRow(
        children: [
          Expanded(
            child: AppText.h3(
              _getSectionTitle(navigationState.currentSection),
            ),
          ),
          ResponsiveRow(
            children: [
              IconButton(
                icon: const Icon(AppIcons.add),
                onPressed: () {
                  // TODO: Add new item
                },
              ),
              const SizedBox(width: AppSizes.spacingSM),
              IconButton(
                icon: const Icon(AppIcons.edit),
                onPressed: () {
                  // TODO: Edit current item
                },
              ),
              const SizedBox(width: AppSizes.spacingSM),
              IconButton(
                icon: const Icon(AppIcons.delete),
                onPressed: () {
                  // TODO: Delete current item
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContentArea(AdminNavigationState navigationState) {
    switch (navigationState.currentSection) {
      case AdminSection.dashboard:
        return _buildDashboardContent();
      case AdminSection.about:
        return _buildAboutContent();
      case AdminSection.skills:
        return _buildSkillsContent();
      case AdminSection.education:
        return _buildEducationContent();
      case AdminSection.contact:
        return _buildContactContent();
      default:
        return _buildDashboardContent();
    }
  }

  String _getSectionTitle(AdminSection section) {
    switch (section) {
      case AdminSection.dashboard:
        return 'Dashboard';
      case AdminSection.about:
        return 'About Management';
      case AdminSection.skills:
        return 'Skills Management';
      case AdminSection.education:
        return 'Education Management';
      case AdminSection.contact:
        return 'Contact Management';
      default:
        return 'Dashboard';
    }
  }

  Widget _buildDashboardContent() {
    return ResponsiveContainer(
      mobilePadding: const EdgeInsets.all(AppSizes.paddingMD),
      desktopPadding: const EdgeInsets.all(AppSizes.paddingXL),
      child: ResponsiveColumn(
        children: [
          _buildStatCard('Total Items', '24', AppColors.primary),
          _buildStatCard('Recent Updates', '8', AppColors.secondary),
          _buildStatCard('Active Users', '156', AppColors.success),
          _buildStatCard('Messages', '3', AppColors.warning),
        ],
      ),
    );
  }

  Widget _buildAboutContent() {
    return ResponsiveContainer(
      mobilePadding: const EdgeInsets.all(AppSizes.paddingMD),
      desktopPadding: const EdgeInsets.all(AppSizes.paddingXL),
      child: AppText.medium('About content will be displayed here'),
    );
  }

  Widget _buildSkillsContent() {
    return ResponsiveContainer(
      mobilePadding: const EdgeInsets.all(AppSizes.paddingMD),
      desktopPadding: const EdgeInsets.all(AppSizes.paddingXL),
      child: AppText.medium('Skills content will be displayed here'),
    );
  }

  Widget _buildEducationContent() {
    return ResponsiveContainer(
      mobilePadding: const EdgeInsets.all(AppSizes.paddingMD),
      desktopPadding: const EdgeInsets.all(AppSizes.paddingXL),
      child: AppText.medium('Education content will be displayed here'),
    );
  }

  Widget _buildContactContent() {
    return ResponsiveContainer(
      mobilePadding: const EdgeInsets.all(AppSizes.paddingMD),
      desktopPadding: const EdgeInsets.all(AppSizes.paddingXL),
      child: AppText.medium('Contact content will be displayed here'),
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return ResponsiveContainer(
      mobilePadding: const EdgeInsets.all(AppSizes.paddingMD),
      desktopPadding: const EdgeInsets.all(AppSizes.paddingLG),
      child: ResponsiveContainer(
        mobileDecoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppSizes.radiusMD),
        ),
        desktopDecoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppSizes.radiusMD),
        ),
        child: ResponsiveColumn(
          children: [
            AppText.medium(
              title,
              color: color,
              fontWeight: FontWeight.w600,
            ),
            AppText.h2(
              value,
              color: color,
            ),
          ],
        ),
      ),
    );
  }
}
