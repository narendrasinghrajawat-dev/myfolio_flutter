import 'package:flutter/material.dart';
import '../config/app_theme_colors.dart';
import '../constants/app_sizes.dart';
import '../utils/responsive_helper.dart';

/// Responsive layout widget that automatically adapts to screen size
/// Handles mobile, tablet, and desktop layouts in a single place
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;
  final Widget Function(BuildContext)? builder;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final bool centerContent;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
    this.builder,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    this.padding,
    this.backgroundColor,
    this.centerContent = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = _buildContent(context);

    if (centerContent) {
      content = Center(child: content);
    }

    final container = Container(
      color: backgroundColor,
      padding: padding,
      child: content,
    );

    return container;
  }

  Widget _buildContent(BuildContext context) {
    if (builder != null) {
      return builder!(context);
    }

    return _getResponsiveChild(context);
  }

  Widget _getResponsiveChild(BuildContext context) {
    if (context.isDesktop && desktop != null) {
      return desktop!;
    }
    if (context.isTablet && tablet != null) {
      return tablet!;
    }
    return mobile;
  }
}

/// Responsive container that adapts width and padding based on screen size
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final double? mobileMaxWidth;
  final double? tabletMaxWidth;
  final double? desktopMaxWidth;
  final EdgeInsets? mobilePadding;
  final EdgeInsets? tabletPadding;
  final EdgeInsets? desktopPadding;
  final Alignment? alignment;
  final bool center;
  final Color? backgroundColor;
  final double? borderRadius;
  final bool useCard;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.mobileMaxWidth,
    this.tabletMaxWidth,
    this.desktopMaxWidth,
    this.mobilePadding,
    this.tabletPadding,
    this.desktopPadding,
    this.alignment,
    this.center = true,
    this.backgroundColor,
    this.borderRadius,
    this.useCard = false,
  });

  @override
  Widget build(BuildContext context) {
    final maxWidth = _getMaxWidth(context);
    final padding = _getPadding(context);

    Widget content = ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );

    if (center) {
      content = Center(child: content);
    }

    if (useCard || backgroundColor != null || borderRadius != null) {
      content = Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? (useCard ? AppThemeColors.lightSurface : null),
          borderRadius: BorderRadius.circular(borderRadius ?? AppSizes.radiusMD),
          boxShadow: useCard
              ? [
                  BoxShadow(
                    color: AppThemeColors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: content,
      );
    }

    if (alignment != null) {
      content = Align(alignment: alignment ?? Alignment.center, child: content);
    }

    return content;
  }

  double _getMaxWidth(BuildContext context) {
    if (context.isDesktop) {
      return desktopMaxWidth ?? 1200;
    }
    if (context.isTablet) {
      return tabletMaxWidth ?? 800;
    }
    return mobileMaxWidth ?? double.infinity;
  }

  EdgeInsets _getPadding(BuildContext context) {
    if (context.isDesktop) {
      return desktopPadding ?? const EdgeInsets.all(AppSizes.paddingXL);
    }
    if (context.isTablet) {
      return tabletPadding ?? const EdgeInsets.all(AppSizes.paddingLG);
    }
    return mobilePadding ?? const EdgeInsets.all(AppSizes.paddingMD);
  }
}

/// Responsive grid that adapts column count based on screen size
class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final int mobileColumns;
  final int? tabletColumns;
  final int? desktopColumns;
  final double spacing;
  final double runSpacing;
  final EdgeInsets? padding;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.mobileColumns = 1,
    this.tabletColumns,
    this.desktopColumns,
    this.spacing = 16,
    this.runSpacing = 16,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final columns = ResponsiveHelper.getGridColumns(
      context,
      maxColumns: desktopColumns ?? 4,
    );

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          crossAxisSpacing: spacing,
          mainAxisSpacing: runSpacing,
        ),
        itemCount: children.length,
        itemBuilder: (context, index) => children[index],
      ),
    );
  }
}

/// Responsive spacing that adapts based on screen size
class ResponsiveSpacing extends StatelessWidget {
  final double mobile;
  final double? tablet;
  final double? desktop;

  const ResponsiveSpacing({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    final spacing = ResponsiveHelper.getResponsiveSpacing(context, mobile);
    return SizedBox(height: spacing);
  }

  static double getValue(BuildContext context, double base) {
    return ResponsiveHelper.getResponsiveSpacing(context, base);
  }
}

/// Responsive screen wrapper for full-screen layouts
class ResponsiveScreen extends StatelessWidget {
  final Widget child;
  final Widget? mobileAppBar;
  final Widget? tabletAppBar;
  final Widget? desktopAppBar;
  final Widget? mobileBottomBar;
  final Widget? tabletBottomBar;
  final Widget? desktopBottomBar;
  final bool useSafeArea;
  final Color? backgroundColor;

  const ResponsiveScreen({
    super.key,
    required this.child,
    this.mobileAppBar,
    this.tabletAppBar,
    this.desktopAppBar,
    this.mobileBottomBar,
    this.tabletBottomBar,
    this.desktopBottomBar,
    this.useSafeArea = true,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = Scaffold(
      backgroundColor: backgroundColor,
      appBar: _getAppBar(context) as PreferredSizeWidget?,
      body: useSafeArea ? SafeArea(child: child) : child,
      bottomNavigationBar: _getBottomBar(context),
    );

    return content;
  }

  Widget? _getAppBar(BuildContext context) {
    if (context.isDesktop && desktopAppBar != null) {
      return desktopAppBar;
    }
    if (context.isTablet && tabletAppBar != null) {
      return tabletAppBar;
    }
    return mobileAppBar;
  }

  Widget? _getBottomBar(BuildContext context) {
    if (context.isDesktop && desktopBottomBar != null) {
      return desktopBottomBar;
    }
    if (context.isTablet && tabletBottomBar != null) {
      return tabletBottomBar;
    }
    return mobileBottomBar;
  }
}
