import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';
import '../constants/app_colors.dart';

/// A reusable text widget that respects the app's typography.
class AppText extends StatelessWidget {
  final String data;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const AppText(
    this.data, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: style ?? const TextStyle(fontFamily: AppTheme.fontInter),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
