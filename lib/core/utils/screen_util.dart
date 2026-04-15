import 'package:flutter/material.dart';
import '../constants/app_breakpoints.dart';

class ScreenUtil {
  // Get screen width
  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  // Get screen height
  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  // Check if device is mobile
  static bool isMobile(BuildContext context) {
    return ScreenUtil.getWidth(context) < AppBreakpoints.mobile;
  }

  // Check if device is tablet
  static bool isTablet(BuildContext context) {
    return ScreenUtil.getWidth(context) >= AppBreakpoints.mobile && 
           ScreenUtil.getWidth(context) < AppBreakpoints.desktop;
  }

  // Check if device is desktop
  static bool isDesktop(BuildContext context) {
    return ScreenUtil.getWidth(context) >= AppBreakpoints.desktop;
  }

  // Get device type
  static String getDeviceType(BuildContext context) {
    if (ScreenUtil.isDesktop(context)) {
      return 'Desktop';
    } else if (ScreenUtil.isTablet(context)) {
      return 'Tablet';
    } else {
      return 'Mobile';
    }
  }

  // Get responsive value based on screen size
  static T getResponsiveValue<T>({
    required BuildContext context,
    required T mobile,
    required T tablet,
    required T desktop,
  }) {
    if (ScreenUtil.isDesktop(context)) {
      return desktop;
    } else if (ScreenUtil.isTablet(context)) {
      return tablet;
    } else {
      return mobile;
    }
  }

  // Get responsive size based on screen width
  static double getResponsiveSize({
    required BuildContext context,
    required double mobileSize,
    required double tabletSize,
    required double desktopSize,
  }) {
    if (ScreenUtil.isDesktop(context)) {
      return desktopSize;
    } else if (ScreenUtil.isTablet(context)) {
      return tabletSize;
    } else {
      return mobileSize;
    }
  }

  // Get responsive padding based on screen size
  static double getResponsivePadding({
    required BuildContext context,
    required double mobilePadding,
    required double tabletPadding,
    required double desktopPadding,
  }) {
    if (ScreenUtil.isDesktop(context)) {
      return desktopPadding;
    } else if (ScreenUtil.isTablet(context)) {
      return tabletPadding;
    } else {
      return mobilePadding;
    }
  }

  // Get responsive font size based on screen size
  static double getResponsiveFontSize({
    required BuildContext context,
    required double mobileFontSize,
    required double tabletFontSize,
    required double desktopFontSize,
  }) {
    if (ScreenUtil.isDesktop(context)) {
      return desktopFontSize;
    } else if (ScreenUtil.isTablet(context)) {
      return tabletFontSize;
    } else {
      return mobileFontSize;
    }
  }

  // Get responsive columns based on screen size
  static int getResponsiveColumns({
    required BuildContext context,
    required int mobileColumns,
    required int tabletColumns,
    required int desktopColumns,
  }) {
    if (ScreenUtil.isDesktop(context)) {
      return desktopColumns;
    } else if (ScreenUtil.isTablet(context)) {
      return tabletColumns;
    } else {
      return mobileColumns;
    }
  }

  // Get responsive grid count based on screen size
  static int getResponsiveGridCount({
    required BuildContext context,
    required int mobileCount,
    required int tabletCount,
    required int desktopCount,
  }) {
    if (ScreenUtil.isDesktop(context)) {
      return desktopCount;
    } else if (ScreenUtil.isTablet(context)) {
      return tabletCount;
    } else {
      return mobileCount;
    }
  }

  // Calculate safe area for different platforms
  static EdgeInsets getSafeAreaPadding(BuildContext context) {
    if (ScreenUtil.isMobile(context)) {
      return const EdgeInsets.only(bottom: 24.0); // Account for bottom navigation
    } else if (ScreenUtil.isTablet(context)) {
      return const EdgeInsets.only(bottom: 16.0);
    } else {
      return EdgeInsets.zero;
    }
  }

  // Get screen orientation
  static Orientation getOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }

  // Check if landscape orientation
  static bool isLandscape(BuildContext context) {
    return ScreenUtil.getOrientation(context) == Orientation.landscape;
  }

  // Check if portrait orientation
  static bool isPortrait(BuildContext context) {
    return ScreenUtil.getOrientation(context) == Orientation.portrait;
  }

  // Get status bar height
  static double getStatusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  // Get view insets
  static EdgeInsets getViewInsets(BuildContext context) {
    return MediaQuery.of(context).viewInsets;
  }

  // Calculate available screen height (excluding status bar and safe area)
  static double getAvailableHeight(BuildContext context) {
    return ScreenUtil.getHeight(context) - 
           ScreenUtil.getStatusBarHeight(context) - 
           ScreenUtil.getSafeAreaPadding(context).bottom;
  }
}
