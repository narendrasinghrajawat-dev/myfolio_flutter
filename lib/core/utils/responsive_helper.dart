import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';

/// Responsive UI helper for app and web
/// Provides utilities to handle different screen sizes
class ResponsiveHelper {
  ResponsiveHelper._();

  /// Get screen type based on width
  static ScreenType getScreenType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    if (width < AppSizes.mobileBreakpoint) {
      return ScreenType.mobile;
    } else if (width < AppSizes.tabletBreakpoint) {
      return ScreenType.mobileLarge;
    } else if (width < AppSizes.desktopBreakpoint) {
      return ScreenType.tablet;
    } else if (width < AppSizes.largeDesktopBreakpoint) {
      return ScreenType.desktop;
    } else {
      return ScreenType.desktopLarge;
    }
  }

  /// Check if screen is mobile
  static bool isMobile(BuildContext context) {
    return getScreenType(context) == ScreenType.mobile;
  }

  /// Check if screen is tablet
  static bool isTablet(BuildContext context) {
    return getScreenType(context) == ScreenType.tablet;
  }

  /// Check if screen is desktop
  static bool isDesktop(BuildContext context) {
    final type = getScreenType(context);
    return type == ScreenType.desktop || type == ScreenType.desktopLarge;
  }

  /// Check if screen is web (tablet or desktop)
  static bool isWeb(BuildContext context) {
    return !isMobile(context);
  }

  /// Get responsive value based on screen type
  static T getValue<T>({
    required BuildContext context,
    required T mobile,
    T? mobileLarge,
    T? tablet,
    T? desktop,
    T? desktopLarge,
  }) {
    switch (getScreenType(context)) {
      case ScreenType.mobile:
        return mobile;
      case ScreenType.mobileLarge:
        return mobileLarge ?? tablet ?? desktop ?? mobile;
      case ScreenType.tablet:
        return tablet ?? desktop ?? mobile;
      case ScreenType.desktop:
        return desktop ?? mobile;
      case ScreenType.desktopLarge:
        return desktopLarge ?? desktop ?? mobile;
    }
  }

  /// Get responsive padding
  static EdgeInsets getResponsivePadding(BuildContext context) {
    final type = getScreenType(context);
    
    switch (type) {
      case ScreenType.mobile:
        return const EdgeInsets.all(AppSizes.paddingMD);
      case ScreenType.mobileLarge:
      case ScreenType.tablet:
        return const EdgeInsets.all(AppSizes.paddingLG);
      case ScreenType.desktop:
      case ScreenType.desktopLarge:
        return const EdgeInsets.all(AppSizes.paddingXL);
    }
  }

  /// Get responsive font size
  static double getResponsiveFontSize(BuildContext context, double baseSize) {
    final type = getScreenType(context);
    
    switch (type) {
      case ScreenType.mobile:
        return baseSize;
      case ScreenType.mobileLarge:
        return baseSize * 1.1;
      case ScreenType.tablet:
        return baseSize * 1.2;
      case ScreenType.desktop:
        return baseSize * 1.3;
      case ScreenType.desktopLarge:
        return baseSize * 1.4;
    }
  }

  /// Get responsive icon size
  static double getResponsiveIconSize(BuildContext context, double baseSize) {
    final type = getScreenType(context);
    
    switch (type) {
      case ScreenType.mobile:
        return baseSize;
      case ScreenType.mobileLarge:
        return baseSize * 1.1;
      case ScreenType.tablet:
        return baseSize * 1.2;
      case ScreenType.desktop:
        return baseSize * 1.3;
      case ScreenType.desktopLarge:
        return baseSize * 1.4;
    }
  }

  /// Get responsive border radius
  static double getResponsiveBorderRadius(BuildContext context, double baseRadius) {
    final type = getScreenType(context);
    
    switch (type) {
      case ScreenType.mobile:
        return baseRadius;
      case ScreenType.mobileLarge:
      case ScreenType.tablet:
        return baseRadius * 1.2;
      case ScreenType.desktop:
      case ScreenType.desktopLarge:
        return baseRadius * 1.4;
    }
  }

  /// Get responsive max width for content
  static double getMaxContentWidth(BuildContext context) {
    final type = getScreenType(context);
    
    switch (type) {
      case ScreenType.mobile:
      case ScreenType.mobileLarge:
        return double.infinity;
      case ScreenType.tablet:
        return 600;
      case ScreenType.desktop:
        return 800;
      case ScreenType.desktopLarge:
        return 1200;
    }
  }

  /// Get responsive number of columns for grid
  static int getGridColumns(BuildContext context, {int maxColumns = 4}) {
    final type = getScreenType(context);
    
    switch (type) {
      case ScreenType.mobile:
        return 1;
      case ScreenType.mobileLarge:
        return 2;
      case ScreenType.tablet:
        return 2;
      case ScreenType.desktop:
        return 3;
      case ScreenType.desktopLarge:
        return maxColumns;
    }
  }

  /// Get responsive spacing
  static double getResponsiveSpacing(BuildContext context, double baseSpacing) {
    final type = getScreenType(context);
    
    switch (type) {
      case ScreenType.mobile:
        return baseSpacing;
      case ScreenType.mobileLarge:
        return baseSpacing * 1.2;
      case ScreenType.tablet:
        return baseSpacing * 1.4;
      case ScreenType.desktop:
        return baseSpacing * 1.6;
      case ScreenType.desktopLarge:
        return baseSpacing * 1.8;
    }
  }

  /// Check if keyboard is visible
  static bool isKeyboardVisible(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom > 0;
  }

  /// Get safe area padding
  static EdgeInsets getSafeAreaPadding(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  /// Check if device is in landscape mode
  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  /// Check if device is in portrait mode
  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }
}

/// Screen type enum
enum ScreenType {
  mobile,
  mobileLarge,
  tablet,
  desktop,
  desktopLarge,
}

/// Extension on BuildContext for easy access to responsive helpers
extension ResponsiveContext on BuildContext {
  ScreenType get screenType => ResponsiveHelper.getScreenType(this);
  bool get isMobile => ResponsiveHelper.isMobile(this);
  bool get isTablet => ResponsiveHelper.isTablet(this);
  bool get isDesktop => ResponsiveHelper.isDesktop(this);
  bool get isWeb => ResponsiveHelper.isWeb(this);
  bool get isKeyboardVisible => ResponsiveHelper.isKeyboardVisible(this);
  bool get isLandscape => ResponsiveHelper.isLandscape(this);
  bool get isPortrait => ResponsiveHelper.isPortrait(this);
}
