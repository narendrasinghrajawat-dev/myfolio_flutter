import 'package:flutter/material.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/responsive_builder.dart';


class AdminFormComponents {
  // Text field with responsive padding and styling
  static Widget buildTextField({
    required String label,
    required TextEditingController controller,
    String? hintText,
    IconData? prefixIcon,
    IconData? suffixIcon,
    VoidCallback? onSuffixIconPressed,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return ResponsiveContainer(
      mobilePadding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingSM),
      desktopPadding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMD),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: suffixIcon != null
              ? IconButton(
                  icon: Icon(suffixIcon),
                  onPressed: onSuffixIconPressed,
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMD),
            borderSide: BorderSide(color: AppColors.grey300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMD),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingMD,
            vertical: AppSizes.paddingSM,
          ),
        ),
        validator: validator,
      ),
    );
  }

  // Dropdown field with responsive design
  static Widget buildDropdownField<T>({
    required String label,
    required T? value,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?>? onChanged,
    String? hintText,
    IconData? prefixIcon,
  }) {
    return ResponsiveContainer(
      mobilePadding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingSM),
      desktopPadding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMD),
      child: DropdownButtonFormField<T>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMD),
            borderSide: BorderSide(color: AppColors.grey300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMD),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingMD,
            vertical: AppSizes.paddingSM,
          ),
        ),
        items: items,
        onChanged: onChanged,
      ),
    );
  }

  // Text area with responsive design
  static Widget buildTextArea({
    required String label,
    required TextEditingController controller,
    String? hintText,
    int maxLines = 3,
    String? Function(String?)? validator,
  }) {
    return ResponsiveContainer(
      mobilePadding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingSM),
      desktopPadding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMD),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMD),
            borderSide: BorderSide(color: AppColors.grey300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMD),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
          contentPadding: const EdgeInsets.all(AppSizes.paddingMD),
        ),
        validator: validator,
      ),
    );
  }

  // Date picker with responsive design
  static Widget buildDateField({
    required BuildContext context,
    required String label,
    required DateTime? selectedDate,
    required ValueChanged<DateTime?> onChanged,
    String? hintText,
    IconData? prefixIcon,
  }) {
    return ResponsiveContainer(
      mobilePadding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingSM),
      desktopPadding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMD),
      child: InkWell(
        onTap: () async {
          final date = await showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (date != null) {
            onChanged(date);
          }
        },
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            hintText: hintText,
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMD),
              borderSide: BorderSide(color: AppColors.grey300),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSizes.paddingMD,
              vertical: AppSizes.paddingSM,
            ),
          ),
          child: Text(
            selectedDate != null
                ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                : hintText ?? 'Select date',
          ),
        ),
      ),
    );
  }

  // Image picker with responsive design
  static Widget buildImagePicker({
    required String label,
    String? imageUrl,
    required VoidCallback onPickImage,
    double? height,
    double? width,
  }) {
    return ResponsiveContainer(
      mobilePadding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingSM),
      desktopPadding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMD),
      child: ResponsiveColumn(
        children: [
          AppText.medium(label),
          const SizedBox(height: AppSizes.spacingSM),
          GestureDetector(
            onTap: onPickImage,
            child: Container(
              height: height ?? 200,
              width: width ?? double.infinity,
              decoration: BoxDecoration(
                color: AppColors.grey100,
                border: Border.all(color: AppColors.grey300),
                borderRadius: BorderRadius.circular(AppSizes.radiusMD),
              ),
              child: imageUrl != null && imageUrl!.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(AppSizes.radiusMD),
                      child: Image.network(
                        imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildImagePlaceholder();
                        },
                      ),
                    )
                  : _buildImagePlaceholder(),
            ),
          ),
        ],
      ),
    );
  }

  // Image placeholder for when no image is selected
  static Widget _buildImagePlaceholder() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.grey100,
        border: Border.all(color: AppColors.grey300),
        borderRadius: BorderRadius.circular(AppSizes.radiusMD),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_photo_alternate,
            size: AppSizes.iconLG,
            color: AppColors.grey600,
          ),
          const SizedBox(height: AppSizes.spacingSM),
          AppText.small('Tap to add image'),
        ],
      ),
    );
  }

  // Tags input field with responsive design
  static Widget buildTagsField({
    required String label,
    required List<String> tags,
    required ValueChanged<List<String>> onChanged,
    String? hintText,
    IconData? prefixIcon,
  }) {
    return ResponsiveContainer(
      mobilePadding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingSM),
      desktopPadding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMD),
      child: ResponsiveColumn(
        children: [
          AppText.medium(label),
          const SizedBox(height: AppSizes.spacingSM),
          ResponsiveContainer(
            mobileDecoration: BoxDecoration(
              color: AppColors.surface,
              border: Border.all(color: AppColors.grey300),
              borderRadius: BorderRadius.circular(AppSizes.radiusMD),
            ),
            desktopDecoration: BoxDecoration(
              color: AppColors.surface,
              border: Border.all(color: AppColors.grey300),
              borderRadius: BorderRadius.circular(AppSizes.radiusMD),
            ),
            child: Wrap(
              spacing: AppSizes.spacingSM,
              runSpacing: AppSizes.spacingSM,
              children: tags.map((tag) {
                return Chip(
                  label: AppText.small(tag),
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  deleteIcon: Icon(
                    Icons.close,
                    size: AppSizes.iconSM,
                    color: AppColors.grey600,
                  ),
                  onDeleted: () {
                    final newTags = List<String>.from(tags);
                    newTags.remove(tag);
                    onChanged(newTags);
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // Switch with responsive design
  static Widget buildSwitch({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
    String? description,
  }) {
    return ResponsiveContainer(
      mobilePadding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingSM),
      desktopPadding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMD),
      child: ResponsiveRow(
        children: [
          Expanded(
            child: ResponsiveColumn(
              children: [
                AppText.medium(label),
                if (description != null)
                  AppText.small(
                    description!,
                    color: AppColors.grey600,
                  ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  // Save/Cancel buttons with responsive design
  static Widget buildActionButtons({
    required VoidCallback onSave,
    required VoidCallback onCancel,
    bool isLoading = false,
  }) {
    return ResponsiveRow(
      spacing: AppSizes.spacingMD,
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: isLoading ? null : onCancel,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingLG,
                vertical: AppSizes.paddingSM,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusMD),
              ),
            ),
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : AppText.medium(AppStrings.actionCancel),
          ),
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: isLoading ? null : onSave,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.onPrimary,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingLG,
                vertical: AppSizes.paddingSM,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusMD),
              ),
            ),
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.onPrimary),
                    ),
                  )
                : AppText.medium(AppStrings.actionSave),
          ),
        ),
      ],
    );
  }
}
