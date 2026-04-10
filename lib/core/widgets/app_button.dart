import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../theme/app_theme.dart';

/// A reusable button that follows the app's design language.
class AppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final bool isPrimary;
  final bool isLoading;

  const AppButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.isPrimary = true,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final background = isPrimary ? AppColors.primary : AppColors.grey300;
    final foreground = isPrimary ? AppColors.white : AppColors.black;
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: background,
        foregroundColor: foreground,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.spacingLarge,
          vertical: AppSizes.spacingMedium,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        ),
      ),
      child: isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.white),
            )
          : Text(label, style: const TextStyle(fontFamily: AppTheme.fontInter)),
    );
  }
}
