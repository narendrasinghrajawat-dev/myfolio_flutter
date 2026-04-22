import 'package:flutter/material.dart';
import '../config/app_theme_colors.dart';
import '../constants/app_sizes.dart';
import 'common_text.dart';

/// Common button widget with multiple variants
class CommonButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final CommonButtonType type;
  final CommonButtonSize size;
  final bool enabled;
  final bool isLoading;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? disabledBackgroundColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;

  const CommonButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = CommonButtonType.primary,
    this.size = CommonButtonSize.medium,
    this.enabled = true,
    this.isLoading = false,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.disabledBackgroundColor,
    this.borderRadius,
    this.padding,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = !enabled || isLoading;

    return SizedBox(
      width: width,
      height: height ?? _getHeight(),
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isDisabled
              ? (disabledBackgroundColor ?? AppThemeColors.grey300)
              : (backgroundColor ?? _getBackgroundColor()),
          foregroundColor: foregroundColor ?? AppThemeColors.white,
          padding: padding ?? _getPadding(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? AppSizes.radiusMD),
          ),
          elevation: type == CommonButtonType.outlined ? 0 : 2,
          side: type == CommonButtonType.outlined
              ? const BorderSide(color: AppThemeColors.primary)
              : null,
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: _getIconSize()),
                    const SizedBox(width: AppSizes.spacingSM),
                  ],
                  CommonText(
                    text,
                    type: _getTextType(),
                    color: foregroundColor ?? AppThemeColors.white,
                  ),
                ],
              ),
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (type) {
      case CommonButtonType.primary:
        return AppThemeColors.primary;
      case CommonButtonType.secondary:
        return AppThemeColors.secondary;
      case CommonButtonType.accent:
        return AppThemeColors.accent;
      case CommonButtonType.success:
        return AppThemeColors.success;
      case CommonButtonType.warning:
        return AppThemeColors.warning;
      case CommonButtonType.danger:
        return AppThemeColors.error;
      case CommonButtonType.outlined:
        return AppThemeColors.transparent;
    }
  }

  double _getHeight() {
    switch (size) {
      case CommonButtonSize.small:
        return AppSizes.buttonHeightSM;
      case CommonButtonSize.medium:
        return AppSizes.buttonHeightMD;
      case CommonButtonSize.large:
        return AppSizes.buttonHeightLG;
    }
  }

  EdgeInsetsGeometry _getPadding() {
    switch (size) {
      case CommonButtonSize.small:
        return const EdgeInsets.symmetric(
          horizontal: AppSizes.paddingMD,
          vertical: AppSizes.paddingXS,
        );
      case CommonButtonSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: AppSizes.paddingLG,
          vertical: AppSizes.paddingSM,
        );
      case CommonButtonSize.large:
        return const EdgeInsets.symmetric(
          horizontal: AppSizes.paddingXL,
          vertical: AppSizes.paddingMD,
        );
    }
  }

  CommonTextType _getTextType() {
    switch (size) {
      case CommonButtonSize.small:
        return CommonTextType.small;
      case CommonButtonSize.medium:
        return CommonTextType.medium;
      case CommonButtonSize.large:
        return CommonTextType.large;
    }
  }

  double _getIconSize() {
    switch (size) {
      case CommonButtonSize.small:
        return 16;
      case CommonButtonSize.medium:
        return 20;
      case CommonButtonSize.large:
        return 24;
    }
  }
}

enum CommonButtonType {
  primary,
  secondary,
  accent,
  success,
  warning,
  danger,
  outlined,
}

enum CommonButtonSize {
  small,
  medium,
  large,
}
