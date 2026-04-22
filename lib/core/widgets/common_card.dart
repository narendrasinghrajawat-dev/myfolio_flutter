import 'package:flutter/material.dart';
import '../config/app_theme_colors.dart';
import '../constants/app_sizes.dart';

/// Common card widget with multiple variants
class CommonCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? shadowColor;
  final double? elevation;
  final CommonCardVariant variant;
  final VoidCallback? onTap;
  final Border? border;
  final double? width;
  final double? height;

  const CommonCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.backgroundColor,
    this.shadowColor,
    this.elevation,
    this.variant = CommonCardVariant.elevated,
    this.onTap,
    this.border,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor ?? _getBackgroundColor(),
        borderRadius: BorderRadius.circular(borderRadius ?? AppSizes.radiusMD),
        border: border,
        boxShadow: _getBoxShadow(),
      ),
      padding: padding ?? _getDefaultPadding(),
      child: child,
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius ?? AppSizes.radiusMD),
        child: card,
      );
    }

    return card;
  }

  Color _getBackgroundColor() {
    switch (variant) {
      case CommonCardVariant.elevated:
        return AppThemeColors.lightSurface;
      case CommonCardVariant.filled:
        return AppThemeColors.grey100;
      case CommonCardVariant.outlined:
        return AppThemeColors.transparent;
      case CommonCardVariant.primary:
        return AppThemeColors.primary.withOpacity(0.1);
    }
  }

  List<BoxShadow>? _getBoxShadow() {
    if (variant == CommonCardVariant.outlined) return null;

    return [
      BoxShadow(
        color: shadowColor ?? AppThemeColors.black.withOpacity(0.1),
        blurRadius: (elevation ?? 2) * 2,
        offset: Offset(0, elevation ?? 2),
      ),
    ];
  }

  EdgeInsetsGeometry _getDefaultPadding() {
    return const EdgeInsets.all(AppSizes.paddingMD);
  }
}

enum CommonCardVariant {
  elevated,
  filled,
  outlined,
  primary,
}
