import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../config/app_theme_colors.dart';
import '../constants/app_sizes.dart';
import 'common_icon.dart';
import 'common_text.dart';

/// Common text field widget with multiple variants
class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final bool obscureText;
  final bool enabled;
  final int? maxLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final bool autofocus;
  final EdgeInsetsGeometry? contentPadding;
  final double? borderRadius;
  final CommonTextFieldVariant variant;

  const CommonTextField({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.obscureText = false,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.textInputAction,
    this.autofocus = false,
    this.contentPadding,
    this.borderRadius,
    this.variant = CommonTextFieldVariant.outlined,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelText != null) ...[
          CommonText.small(
            labelText!,
            fontWeight: FontWeight.w500,
            color: AppThemeColors.grey700,
          ),
          const SizedBox(height: AppSizes.spacingXS),
        ],
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          enabled: enabled,
          maxLines: maxLines,
          maxLength: maxLength,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: validator,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
          focusNode: focusNode,
          textInputAction: textInputAction,
          autofocus: autofocus,
          style: TextStyle(
            fontSize: AppSizes.fontMD,
            color: enabled ? AppThemeColors.lightOnBackground : AppThemeColors.grey500,
          ),
          decoration: _getDecoration(),
        ),
        if (errorText != null) ...[
          const SizedBox(height: AppSizes.spacingXS),
          CommonText.verySmall(
            errorText!,
            color: AppThemeColors.error,
          ),
        ],
      ],
    );
  }

  InputDecoration _getDecoration() {
    final defaultPadding = contentPadding ??
        EdgeInsets.symmetric(
          horizontal: AppSizes.paddingMD,
          vertical: maxLines == 1 ? AppSizes.paddingSM : AppSizes.paddingMD,
        );

    return InputDecoration(
      hintText: hintText,
      prefixIcon: prefixIcon != null
          ? Padding(
              padding: const EdgeInsets.only(left: AppSizes.paddingMD, right: AppSizes.paddingSM),
              child: CommonIcon.small(
                prefixIcon!,
                color: AppThemeColors.grey500,
              ),
            )
          : null,
      suffixIcon: suffixIcon != null
          ? IconButton(
              icon: CommonIcon.small(
                suffixIcon!,
                color: AppThemeColors.grey500,
              ),
              onPressed: onSuffixIconPressed,
            )
          : null,
      contentPadding: defaultPadding,
      border: _getBorder(),
      enabledBorder: _getEnabledBorder(),
      focusedBorder: _getFocusedBorder(),
      errorBorder: _getErrorBorder(),
      focusedErrorBorder: _getFocusedErrorBorder(),
      disabledBorder: _getDisabledBorder(),
      filled: variant == CommonTextFieldVariant.filled,
      fillColor: variant == CommonTextFieldVariant.filled
          ? AppThemeColors.grey100
          : null,
      counterText: maxLength != null ? '' : null,
    );
  }

  InputBorder _getBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? AppSizes.radiusMD),
    );
  }

  InputBorder _getEnabledBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? AppSizes.radiusMD),
      borderSide: const BorderSide(color: AppThemeColors.grey300),
    );
  }

  InputBorder _getFocusedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? AppSizes.radiusMD),
      borderSide: const BorderSide(color: AppThemeColors.primary, width: 2),
    );
  }

  InputBorder _getErrorBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? AppSizes.radiusMD),
      borderSide: const BorderSide(color: AppThemeColors.error),
    );
  }

  InputBorder _getFocusedErrorBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? AppSizes.radiusMD),
      borderSide: const BorderSide(color: AppThemeColors.error, width: 2),
    );
  }

  InputBorder _getDisabledBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? AppSizes.radiusMD),
      borderSide: const BorderSide(color: AppThemeColors.grey200),
    );
  }
}

enum CommonTextFieldVariant {
  outlined,
  filled,
  underlined,
}
