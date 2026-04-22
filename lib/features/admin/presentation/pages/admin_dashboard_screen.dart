import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/common_text.dart';
import '../../../../core/widgets/common_button.dart';
import '../../../../core/widgets/responsive_layout.dart';
import '../../../../core/config/app_theme_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../controllers/admin_auth_controller.dart';

class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(adminAuthControllerProvider);

    return Scaffold(
      backgroundColor: AppThemeColors.lightBackground,
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(adminAuthControllerProvider.notifier).logout();
              // Navigate to admin login
            },
          ),
        ],
      ),
      body: ResponsiveContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText.veryLarge(
              'Welcome, ${authState.admin?.fullName ?? 'Admin'}',
              fontWeight: FontWeight.bold,
            ),
            const ResponsiveSpacing(mobile: AppSizes.spacingSM),
            CommonText.small(
              'Manage your portfolio content',
              color: AppThemeColors.grey600,
            ),
            const ResponsiveSpacing(mobile: AppSizes.spacingXL),
            
            // Dashboard sections will be added later
            CommonText.medium(
              'Dashboard sections coming soon...',
              color: AppThemeColors.grey600,
            ),
          ],
        ),
      ),
    );
  }
}
