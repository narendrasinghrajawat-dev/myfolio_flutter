import 'package:codewithnarendra/core/constants/app_breakpoints.dart';
import 'package:flutter/material.dart';

class ScreenUtil {
  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static Orientation getOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }

  static String getDeviceType(BuildContext context) {
    final width = getWidth(context);
    if (width >= AppBreakpoints.desktop) {
      return 'Desktop';
    } else if (width >= AppBreakpoints.tablet) {
      return 'Tablet';
    } else {
      return 'Mobile';
    }
  }

  static bool isMobile(BuildContext context) {
    return getWidth(context) < AppBreakpoints.tablet;
  }

  static bool isTablet(BuildContext context) {
    final width = getWidth(context);
    return width >= AppBreakpoints.tablet && width < AppBreakpoints.desktop;
  }

  static bool isDesktop(BuildContext context) {
    return getWidth(context) >= AppBreakpoints.desktop;
  }
}
