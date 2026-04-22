import 'package:codewithnarendra/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../utils/screen_util.dart';
import '../widgets/responsive_builder.dart';


/// Example usage of the responsive UI system
class ResponsiveExampleScreen extends StatelessWidget {
  const ResponsiveExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive Example'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: ResponsiveColumn(
          children: [
            // Device info section
            ResponsiveContainer(
              mobilePadding: const EdgeInsets.all(16),
              tabletPadding: const EdgeInsets.all(24),
              desktopPadding: const EdgeInsets.all(32),
              mobileDecoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ResponsiveColumn(
                children: [
                  AppText.large(
                    'Device Information',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  _buildDeviceInfo(context),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Responsive grid example
            AppText.h3('Responsive Grid Example'),
            const SizedBox(height: 16),
            ResponsiveGrid(
              mobileColumns: 1,
              tabletColumns: 2,
              desktopColumns: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              children: List.generate(6, (index) {
                return ResponsiveContainer(
                  mobileDecoration: BoxDecoration(
                    color: AppColors.surface,
                    border: Border.all(color: AppColors.grey300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: ResponsiveColumn(
                      children: [
                        AppText.medium('Item ${index + 1}'),
                        const SizedBox(height: 8),
                        AppText.small('Responsive content that adapts'),
                        const SizedBox(height: 4),
                        AppText.xs('Mobile: 1 col, Tablet: 2 cols, Desktop: 3 cols'),
                      ],
                    ),
                  ),
                );
              }),
            ),
            
            const SizedBox(height: 32),
            
            // Responsive row example
            AppText.h3('Responsive Row Example'),
            const SizedBox(height: 16),
            ResponsiveRow(
              spacing: 16,
              children: [
                Expanded(
                  child: ResponsiveContainer(
                    mobileDecoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: AppText.medium('Expanded Item'),
                    ),
                  ),
                ),
                Expanded(
                  child: ResponsiveContainer(
                    mobileDecoration: BoxDecoration(
                      color: AppColors.secondary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: AppText.medium('Flexible Item'),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Responsive text size example
            AppText.h3('Responsive Text Sizes'),
            const SizedBox(height: 16),
            ResponsiveRow(
              children: [
                AppText.large('Large Text', textAlign: TextAlign.center),
                const SizedBox(width: 16),
                AppText.medium('Medium Text', textAlign: TextAlign.center),
                const SizedBox(width: 16),
                AppText.small('Small Text', textAlign: TextAlign.center),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceInfo(BuildContext context) {
    return ResponsiveContainer(
      mobileDecoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.grey300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ResponsiveColumn(
          children: [
            _buildInfoRow('Device Type', ScreenUtil.getDeviceType(context)),
            _buildInfoRow('Screen Width', '${ScreenUtil.getWidth(context).toInt()}px'),
            _buildInfoRow('Screen Height', '${ScreenUtil.getHeight(context).toInt()}px'),
            _buildInfoRow('Orientation', ScreenUtil.getOrientation(context).toString()),
            _buildInfoRow('Is Mobile', ScreenUtil.isMobile(context).toString()),
            _buildInfoRow('Is Tablet', ScreenUtil.isTablet(context).toString()),
            _buildInfoRow('Is Desktop', ScreenUtil.isDesktop(context).toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return ResponsiveRow(
      spacing: 8,
      children: [
        Expanded(
          child: AppText.label(label),
        ),
        Expanded(
          flex: 2,
          child: AppText.medium(value, textAlign: TextAlign.end),
        ),
      ],
    );
  }
}
