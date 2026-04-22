import 'package:flutter/material.dart';
import '../config/app_theme_colors.dart';
import '../constants/app_sizes.dart';

/// Common icon widgets with 5 size variants
class CommonIcon extends StatelessWidget {
  final IconData icon;
  final CommonIconSize size;
  final Color? color;
  final double? customSize;

  const CommonIcon(
    this.icon, {
    super.key,
    this.size = CommonIconSize.medium,
    this.color,
    this.customSize,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: customSize ?? _getSize(),
      color: color ?? AppThemeColors.grey600,
    );
  }

  double _getSize() {
    switch (size) {
      case CommonIconSize.verySmall:
        return AppSizes.iconXS;
      case CommonIconSize.small:
        return AppSizes.iconSM;
      case CommonIconSize.medium:
        return AppSizes.iconMD;
      case CommonIconSize.large:
        return AppSizes.iconLG;
      case CommonIconSize.veryLarge:
        return AppSizes.iconXL;
    }
  }

  // Convenience constructors
  const CommonIcon.verySmall(
    this.icon, {
    super.key,
    this.color,
    this.customSize,
  }) : size = CommonIconSize.verySmall;

  const CommonIcon.small(
    this.icon, {
    super.key,
    this.color,
    this.customSize,
  }) : size = CommonIconSize.small;

  const CommonIcon.medium(
    this.icon, {
    super.key,
    this.color,
    this.customSize,
  }) : size = CommonIconSize.medium;

  const CommonIcon.large(
    this.icon, {
    super.key,
    this.color,
    this.customSize,
  }) : size = CommonIconSize.large;

  const CommonIcon.veryLarge(
    this.icon, {
    super.key,
    this.color,
    this.customSize,
  }) : size = CommonIconSize.veryLarge;
}

enum CommonIconSize {
  verySmall,
  small,
  medium,
  large,
  veryLarge,
}
