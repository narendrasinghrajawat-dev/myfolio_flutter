import 'package:flutter/material.dart';
import '../config/app_theme_colors.dart';
import '../constants/app_sizes.dart';

/// Common container widget with multiple variants
class CommonContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final Color? backgroundColor;
  final CommonContainerVariant variant;
  final Border? border;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final AlignmentGeometry? alignment;
  final BoxShadow? boxShadow;
  final Gradient? gradient;

  const CommonContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.backgroundColor,
    this.variant = CommonContainerVariant.transparent,
    this.border,
    this.width,
    this.height,
    this.constraints,
    this.alignment,
    this.boxShadow,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      constraints: constraints,
      alignment: alignment,
      decoration: BoxDecoration(
        color: gradient == null ? (backgroundColor ?? _getBackgroundColor()) : null,
        gradient: gradient,
        borderRadius: BorderRadius.circular(borderRadius ?? _getBorderRadius()),
        border: border ?? _getBorder(),
        boxShadow: boxShadow != null ? [boxShadow!] : _getBoxShadow(),
      ),
      child: child,
    );
  }

  Color _getBackgroundColor() {
    switch (variant) {
      case CommonContainerVariant.transparent:
        return AppThemeColors.transparent;
      case CommonContainerVariant.filled:
        return AppThemeColors.grey100;
      case CommonContainerVariant.primary:
        return AppThemeColors.primary;
      case CommonContainerVariant.secondary:
        return AppThemeColors.secondary;
      case CommonContainerVariant.surface:
        return AppThemeColors.lightSurface;
      case CommonContainerVariant.outlined:
        return AppThemeColors.transparent;
    }
  }

  double _getBorderRadius() {
    switch (variant) {
      case CommonContainerVariant.transparent:
      case CommonContainerVariant.filled:
      case CommonContainerVariant.primary:
      case CommonContainerVariant.secondary:
      case CommonContainerVariant.surface:
        return AppSizes.radiusMD;
      case CommonContainerVariant.outlined:
        return AppSizes.radiusMD;
    }
  }

  Border? _getBorder() {
    if (variant == CommonContainerVariant.outlined) {
      return Border.all(color: AppThemeColors.grey300);
    }
    return null;
  }

  List<BoxShadow>? _getBoxShadow() {
    switch (variant) {
      case CommonContainerVariant.transparent:
      case CommonContainerVariant.filled:
      case CommonContainerVariant.outlined:
        return null;
      case CommonContainerVariant.primary:
      case CommonContainerVariant.secondary:
      case CommonContainerVariant.surface:
        return [
          BoxShadow(
            color: AppThemeColors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ];
    }
  }
}

enum CommonContainerVariant {
  transparent,
  filled,
  primary,
  secondary,
  surface,
  outlined,
}
