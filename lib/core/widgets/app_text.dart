import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';
import '../constants/app_colors.dart';

/// A reusable text widget that respects the app's typography and provides multiple variants.
class AppText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;

  const AppText({
    Key? key,
    required this.text,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ?? _defaultStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }

  TextStyle get _defaultStyle {
    return const TextStyle(
      fontSize: AppSizes.fontMD,
      color: AppColors.onSurface,
      fontWeight: FontWeight.normal,
    );
  }

  // Large variant
  factory AppText.large(
    String text, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
  }) {
    return AppText(
      key: key,
      text: text,
      style: (style ?? _defaultStyle).copyWith(
        fontSize: AppSizes.fontLG,
        fontWeight: FontWeight.w600,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }

  // Medium variant
  factory AppText.medium(
    String text, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
  }) {
    return AppText(
      key: key,
      text: text,
      style: (style ?? _defaultStyle).copyWith(
        fontSize: AppSizes.fontMD,
        fontWeight: FontWeight.w500,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }

  // Small variant
  factory AppText.small(
    String text, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
  }) {
    return AppText(
      key: key,
      text: text,
      style: (style ?? _defaultStyle).copyWith(
        fontSize: AppSizes.fontSM,
        fontWeight: FontWeight.w400,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }

  // Extra Small variant
  factory AppText.xs(
    String text, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
  }) {
    return AppText(
      key: key,
      text: text,
      style: (style ?? _defaultStyle).copyWith(
        fontSize: AppSizes.fontXS,
        fontWeight: FontWeight.w300,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }

  // Heading variants
  factory AppText.h1(
    String text, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    Color? color,
  }) {
    return AppText(
      key: key,
      text: text,
      style: (style ?? _defaultStyle).copyWith(
        fontSize: AppSizes.fontXXXL,
        fontWeight: FontWeight.bold,
        color: color ?? AppColors.onSurface,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }

  factory AppText.h2(
    String text, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    Color? color,
  }) {
    return AppText(
      key: key,
      text: text,
      style: (style ?? _defaultStyle).copyWith(
        fontSize: AppSizes.fontXXL,
        fontWeight: FontWeight.bold,
        color: color ?? AppColors.onSurface,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }

  factory AppText.h3(
    String text, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    Color? color,
  }) {
    return AppText(
      key: key,
      text: text,
      style: (style ?? _defaultStyle).copyWith(
        fontSize: AppSizes.fontXL,
        fontWeight: FontWeight.bold,
        color: color ?? AppColors.onSurface,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }

  // Caption variants
  factory AppText.caption(
    String text, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    Color? color,
  }) {
    return AppText(
      key: key,
      text: text,
      style: (style ?? _defaultStyle).copyWith(
        fontSize: AppSizes.fontSM,
        fontWeight: FontWeight.w400,
        color: color ?? AppColors.grey600,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }

  // Label variants
  factory AppText.label(
    String text, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    Color? color,
  }) {
    return AppText(
      key: key,
      text: text,
      style: (style ?? _defaultStyle).copyWith(
        fontSize: AppSizes.fontSM,
        fontWeight: FontWeight.w500,
        color: color ?? AppColors.primary,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }

  // Button text variant
  factory AppText.button(
    String text, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
  }) {
    return AppText(
      key: key,
      text: text,
      style: (style ?? _defaultStyle).copyWith(
        fontSize: AppSizes.fontMD,
        fontWeight: FontWeight.w600,
        color: AppColors.onPrimary,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }

  // Error text variant
  factory AppText.error(
    String text, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
  }) {
    return AppText(
      key: key,
      text: text,
      style: (style ?? _defaultStyle).copyWith(
        fontSize: AppSizes.fontMD,
        fontWeight: FontWeight.w400,
        color: AppColors.error,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }

  // Success text variant
  factory AppText.success(
    String text, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
  }) {
    return AppText(
      key: key,
      text: text,
      style: (style ?? _defaultStyle).copyWith(
        fontSize: AppSizes.fontMD,
        fontWeight: FontWeight.w400,
        color: AppColors.success,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }
}
