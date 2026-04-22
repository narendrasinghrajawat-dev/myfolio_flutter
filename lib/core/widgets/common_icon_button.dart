import 'package:flutter/material.dart';
import '../config/app_theme_colors.dart';
import '../constants/app_sizes.dart';
import 'common_icon.dart';

/// Common icon button widgets with 5 size variants
class CommonIconButton extends StatelessWidget {
  final IconData icon;
  final CommonIconSize size;
  final VoidCallback? onPressed;
  final Color? iconColor;
  final Color? backgroundColor;
  final Color? disabledColor;
  final bool enabled;
  final double? borderRadius;
  final BoxShape shape;
  final EdgeInsetsGeometry? padding;

  const CommonIconButton(
    this.icon, {
    super.key,
    this.size = CommonIconSize.medium,
    this.onPressed,
    this.iconColor,
    this.backgroundColor,
    this.disabledColor,
    this.enabled = true,
    this.borderRadius,
    this.shape = BoxShape.circle,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: enabled 
          ? (backgroundColor ?? AppThemeColors.transparent) 
          : (disabledColor ?? AppThemeColors.grey200),
      shape: shape == BoxShape.circle 
          ? const CircleBorder() 
          : RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? AppSizes.radiusMD),
            ),
      child: InkWell(
        onTap: enabled ? onPressed : null,
        customBorder: shape == BoxShape.circle 
            ? const CircleBorder() 
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? AppSizes.radiusMD),
              ),
        child: Padding(
          padding: padding ?? _getPadding(),
          child: CommonIcon(
            icon,
            size: size,
            color: enabled 
                ? (iconColor ?? AppThemeColors.grey600) 
                : AppThemeColors.grey400,
          ),
        ),
      ),
    );
  }

  EdgeInsetsGeometry _getPadding() {
    switch (size) {
      case CommonIconSize.verySmall:
        return const EdgeInsets.all(AppSizes.paddingXS);
      case CommonIconSize.small:
        return const EdgeInsets.all(AppSizes.paddingSM);
      case CommonIconSize.medium:
        return const EdgeInsets.all(AppSizes.paddingMD);
      case CommonIconSize.large:
        return const EdgeInsets.all(AppSizes.paddingLG);
      case CommonIconSize.veryLarge:
        return const EdgeInsets.all(AppSizes.paddingXL);
    }
  }

  // Convenience constructors
  const CommonIconButton.verySmall(
    this.icon, {
    super.key,
    this.onPressed,
    this.iconColor,
    this.backgroundColor,
    this.disabledColor,
    this.enabled = true,
    this.borderRadius,
    this.shape = BoxShape.circle,
    this.padding,
  }) : size = CommonIconSize.verySmall;

  const CommonIconButton.small(
    this.icon, {
    super.key,
    this.onPressed,
    this.iconColor,
    this.backgroundColor,
    this.disabledColor,
    this.enabled = true,
    this.borderRadius,
    this.shape = BoxShape.circle,
    this.padding,
  }) : size = CommonIconSize.small;

  const CommonIconButton.medium(
    this.icon, {
    super.key,
    this.onPressed,
    this.iconColor,
    this.backgroundColor,
    this.disabledColor,
    this.enabled = true,
    this.borderRadius,
    this.shape = BoxShape.circle,
    this.padding,
  }) : size = CommonIconSize.medium;

  const CommonIconButton.large(
    this.icon, {
    super.key,
    this.onPressed,
    this.iconColor,
    this.backgroundColor,
    this.disabledColor,
    this.enabled = true,
    this.borderRadius,
    this.shape = BoxShape.circle,
    this.padding,
  }) : size = CommonIconSize.large;

  const CommonIconButton.veryLarge(
    this.icon, {
    super.key,
    this.onPressed,
    this.iconColor,
    this.backgroundColor,
    this.disabledColor,
    this.enabled = true,
    this.borderRadius,
    this.shape = BoxShape.circle,
    this.padding,
  }) : size = CommonIconSize.veryLarge;
}
