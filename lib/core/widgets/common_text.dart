import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/app_theme_colors.dart';
import '../constants/app_sizes.dart';

/// Common text widgets with Google Fonts
/// 5 types: verysmall, small, medium, large, verylarge
class CommonText extends StatelessWidget {
  final String text;
  final CommonTextType type;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;
  final TextDecoration? decoration;
  final double? height;
  final double? letterSpacing;

  const CommonText(
    this.text, {
    super.key,
    this.type = CommonTextType.medium,
    this.color,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.decoration,
    this.height,
    this.letterSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: _getTextStyle(),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }

  TextStyle _getTextStyle() {
    final baseStyle = GoogleFonts.inter(
      fontSize: _getFontSize(),
      fontWeight: fontWeight ?? _getFontWeight(),
      color: color ?? AppThemeColors.lightOnBackground,
      decoration: decoration,
      height: height,
      letterSpacing: letterSpacing,
    );

    return baseStyle;
  }

  double _getFontSize() {
    switch (type) {
      case CommonTextType.verySmall:
        return AppSizes.fontXS;
      case CommonTextType.small:
        return AppSizes.fontSM;
      case CommonTextType.medium:
        return AppSizes.fontMD;
      case CommonTextType.large:
        return AppSizes.fontLG;
      case CommonTextType.veryLarge:
        return AppSizes.fontXL;
    }
  }

  FontWeight _getFontWeight() {
    switch (type) {
      case CommonTextType.verySmall:
        return FontWeight.w300;
      case CommonTextType.small:
        return FontWeight.w400;
      case CommonTextType.medium:
        return FontWeight.w500;
      case CommonTextType.large:
        return FontWeight.w600;
      case CommonTextType.veryLarge:
        return FontWeight.bold;
    }
  }

  // Convenience constructors
  const CommonText.verySmall(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.decoration,
    this.height,
    this.letterSpacing,
  }) : type = CommonTextType.verySmall;

  const CommonText.small(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.decoration,
    this.height,
    this.letterSpacing,
  }) : type = CommonTextType.small;

  const CommonText.medium(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.decoration,
    this.height,
    this.letterSpacing,
  }) : type = CommonTextType.medium;

  const CommonText.large(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.decoration,
    this.height,
    this.letterSpacing,
  }) : type = CommonTextType.large;

  const CommonText.veryLarge(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.decoration,
    this.height,
    this.letterSpacing,
  }) : type = CommonTextType.veryLarge;
}

enum CommonTextType {
  verySmall,
  small,
  medium,
  large,
  veryLarge,
}
