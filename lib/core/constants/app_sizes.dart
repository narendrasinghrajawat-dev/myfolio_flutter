import 'package:flutter/animation.dart';

abstract final class AppSizes {
  // Padding
  static const double paddingXS = 4.0;
  static const double paddingSM = 8.0;
  static const double paddingMD = 16.0;
  static const double paddingLG = 24.0;
  static const double paddingXL = 32.0;
  static const double paddingXXL = 48.0;
  static const double paddingXXXL = 64.0;

  // Margins
  static const double marginXS = 4.0;
  static const double marginSM = 8.0;
  static const double marginMD = 16.0;
  static const double marginLG = 24.0;
  static const double marginXL = 32.0;
  static const double marginXXL = 48.0;
  static const double marginXXXL = 64.0;

  // Spacing
  static const double spacingXS = 4.0;
  static const double spacingSM = 8.0;
  static const double spacingMD = 16.0;
  static const double spacingLG = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;
  static const double spacingXXXL = 64.0;

  // Border Radius
  static const double radiusXS = 4.0;
  static const double radiusSM = 8.0;
  static const double radiusMD = 12.0;
  static const double radiusLG = 16.0;
  static const double radiusXL = 20.0;
  static const double radiusXXL = 24.0;
  static const double radiusXXXL = 32.0;
  static const double radiusCircular = 50.0;

  // Font Sizes
  static const double fontXXS = 10.0;
  static const double fontXS = 12.0;
  static const double fontSM = 14.0;
  static const double fontMD = 16.0;
  static const double fontLG = 18.0;
  static const double fontXL = 20.0;
  static const double fontXXL = 24.0;
  static const double fontXXXL = 32.0;
  static const double fontXXXXL = 40.0;
  static const double fontXXXXXL = 48.0;

  // Icon Sizes
  static const double iconXXS = 12.0;
  static const double iconXS = 16.0;
  static const double iconSM = 20.0;
  static const double iconMD = 24.0;
  static const double iconLG = 32.0;
  static const double iconXL = 40.0;
  static const double iconXXL = 48.0;
  static const double iconXXXL = 56.0;
  static const double iconXXXXL = 64.0;

  // Elevations
  static const double elevationXS = 1.0;
  static const double elevationSM = 2.0;
  static const double elevationMD = 4.0;
  static const double elevationLG = 8.0;
  static const double elevationXL = 12.0;
  static const double elevationXXL = 16.0;
  static const double elevationXXXL = 24.0;

  // Stroke Width
  static const double strokeHairline = 0.5;
  static const double strokeThin = 1.0;
  static const double strokeNormal = 2.0;
  static const double strokeThick = 3.0;
  static const double strokeExtraThick = 4.0;

  // Screen Dimensions
  static const double screenMaxWidth = 1920.0;
  static const double screenMaxHeight = 1080.0;
  static const double mobileBreakpoint = 600.0;
  static const double tabletBreakpoint = 900.0;
  static const double desktopBreakpoint = 1200.0;
  static const double largeDesktopBreakpoint = 1600.0;

  // Component Heights
  static const double buttonHeightXS = 32.0;
  static const double buttonHeightSM = 40.0;
  static const double buttonHeightMD = 48.0;
  static const double buttonHeightLG = 56.0;
  static const double buttonHeightXL = 64.0;
  static const double inputHeight = 56.0;
  static const double inputHeightSM = 40.0;
  static const double inputHeightLG = 64.0;
  static const double cardMinHeight = 120.0;
  static const double cardMinHeightSM = 80.0;
  static const double cardMinHeightLG = 160.0;

  // Layout Heights
  static const double appBarHeight = 64.0;
  static const double appBarHeightSM = 56.0;
  static const double appBarHeightLG = 72.0;
  static const double bottomNavHeight = 80.0;
  static const double bottomNavHeightSM = 60.0;
  static const double bottomNavHeightLG = 100.0;
  static const double sidebarWidth = 280.0;
  static const double sidebarWidthSM = 240.0;
  static const double sidebarWidthLG = 320.0;
  static const double sidebarCollapsedWidth = 72.0;

  // Border Radius for specific components
  static const double buttonRadius = 8.0;
  static const double cardRadius = 12.0;
  static const double dialogRadius = 16.0;
  static const double chipRadius = 16.0;
  static const double avatarRadius = 50.0;
  static const double imageRadius = 8.0;
  static const double containerRadius = 12.0;
  static const double sheetRadius = 16.0;

  // Grid Spacing
  static const double gridSpacingXS = 4.0;
  static const double gridSpacingSM = 8.0;
  static const double gridSpacingMD = 16.0;
  static const double gridSpacingLG = 24.0;
  static const double gridSpacingXL = 32.0;

  // List Item Heights
  static const double listItemHeightSM = 48.0;
  static const double listItemHeightMD = 56.0;
  static const double listItemHeightLG = 64.0;
  static const double listItemHeightXL = 72.0;
  static const double listItemHeightXXL = 80.0;

  // Tab Bar Heights
  static const double tabBarHeight = 48.0;
  static const double tabBarHeightSM = 40.0;
  static const double tabBarHeightLG = 56.0;

  // Badge Sizes
  static const double badgeSizeSM = 16.0;
  static const double badgeSizeMD = 20.0;
  static const double badgeSizeLG = 24.0;
  static const double badgeSizeXL = 32.0;

  // Avatar Sizes
  static const double avatarSizeXS = 24.0;
  static const double avatarSizeSM = 32.0;
  static const double avatarSizeMD = 48.0;
  static const double avatarSizeLG = 64.0;
  static const double avatarSizeXL = 80.0;
  static const double avatarSizeXXL = 96.0;
  static const double avatarSizeXXXL = 128.0;

  // Image Sizes
  static const double imageSizeXS = 32.0;
  static const double imageSizeSM = 64.0;
  static const double imageSizeMD = 128.0;
  static const double imageSizeLG = 256.0;
  static const double imageSizeXL = 512.0;
  static const double imageSizeXXL = 1024.0;

  // Animation Durations (in milliseconds)
  static const int durationXS = 100;
  static const int durationSM = 200;
  static const int durationMD = 300;
  static const int durationLG = 500;
  static const int durationXL = 700;
  static const int durationXXL = 1000;

  // Curves (for reference)
  static const Curve curveEaseIn = Curves.easeIn;
  static const Curve curveEaseOut = Curves.easeOut;
  static const Curve curveEaseInOut = Curves.easeInOut;
  static const Curve curveFastOutSlowIn = Curves.fastOutSlowIn;
  static const Curve curveBounceIn = Curves.bounceIn;
  static const Curve curveBounceOut = Curves.bounceOut;
  static const Curve curveElasticIn = Curves.elasticIn;
  static const Curve curveElasticOut = Curves.elasticOut;

  // Opacity Levels
  static const double opacityDisabled = 0.38;
  static const double opacityPressed = 0.8;
  static const double opacityHover = 0.04;
  static const double opacityFocus = 0.12;
  static const double opacitySelected = 0.16;
  static const double opacityActivated = 0.24;
  static const double opacityDragged = 0.32;
  static const double opacityScrim = 0.32;
  static const double opacityScrimDark = 0.64;
  static const double opacityOverlay = 0.8;
  static const double opacityOverlayDark = 0.9;

  // Z-Index Levels
  static const int zIndexBackground = 0;
  static const int zIndexContent = 1;
  static const int zIndexAppBar = 2;
  static const int zIndexDrawer = 3;
  static const int zIndexModal = 4;
  static const int zIndexDialog = 5;
  static const int zIndexPopupMenu = 6;
  static const int zIndexTooltip = 7;
  static const int zIndexSnackbar = 8;
  static const int zIndexOverlay = 9;
  static const int zIndexLoading = 10;

  // Minimum Touch Targets
  static const double minTouchTarget = 44.0;
  static const double minTouchTargetSM = 40.0;
  static const double minTouchTargetLG = 48.0;

  // Safe Area Insets
  static const double safeAreaTop = 24.0;
  static const double safeAreaBottom = 16.0;
  static const double safeAreaLeft = 16.0;
  static const double safeAreaRight = 16.0;

  // Progress Indicator Sizes
  static const double progressIndicatorSM = 16.0;
  static const double progressIndicatorMD = 24.0;
  static const double progressIndicatorLG = 32.0;
  static const double progressIndicatorXL = 48.0;

  // Switch Dimensions
  static const double switchWidth = 52.0;
  static const double switchHeight = 28.0;
  static const double switchThumbSize = 24.0;
  static const double switchTrackHeight = 16.0;

  // Checkbox Dimensions
  static const double checkboxSize = 24.0;
  static const double checkboxSizeSM = 20.0;
  static const double checkboxSizeLG = 28.0;

  // Radio Button Dimensions
  static const double radioSize = 24.0;
  static const double radioSizeSM = 20.0;
  static const double radioSizeLG = 28.0;
  static const double radioDotSize = 12.0;

  // Slider Dimensions
  static const double sliderHeight = 4.0;
  static const double sliderThumbSize = 24.0;
  static const double sliderThumbSizeSM = 20.0;
  static const double sliderThumbSizeLG = 28.0;

  // Divider Heights
  static const double dividerHeight = 1.0;
  static const double dividerHeightSM = 0.5;
  static const double dividerHeightLG = 2.0;

  // Shadow Offsets
  static const double shadowOffsetSM = 2.0;
  static const double shadowOffsetMD = 4.0;
  static const double shadowOffsetLG = 8.0;
  static const double shadowOffsetXL = 16.0;
}
