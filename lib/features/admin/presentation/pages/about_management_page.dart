import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/responsive_builder.dart';
import '../widgets/admin_form_components.dart';

class AboutManagementPage extends ConsumerStatefulWidget {
  const AboutManagementPage({super.key});

  @override
  ConsumerState<AboutManagementPage> createState() => _AboutManagementPageState();
}

class _AboutManagementPageState extends ConsumerState<AboutManagementPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _titleController = TextEditingController();
  final _bioController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _locationController = TextEditingController();
  final _websiteController = TextEditingController();
  final _linkedinController = TextEditingController();
  final _githubController = TextEditingController();
  final _resumeController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _titleController.dispose();
    _bioController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    _websiteController.dispose();
    _linkedinController.dispose();
    _githubController.dispose();
    _resumeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: ResponsiveBuilder(
        mobile: _buildMobileLayout(),
        tablet: _buildTabletLayout(),
        desktop: _buildDesktopLayout(),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.paddingMD),
        child: Form(
          key: _formKey,
          child: ResponsiveColumn(
            children: [
              _buildHeader(),
              const SizedBox(height: AppSizes.spacingLG),
              _buildAboutForm(),
              const SizedBox(height: AppSizes.spacingLG),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabletLayout() {
    return SafeArea(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSizes.paddingLG),
              child: Form(
                key: _formKey,
                child: ResponsiveColumn(
                  children: [
                    _buildHeader(),
                    const SizedBox(height: AppSizes.spacingLG),
                    _buildAboutForm(),
                    const SizedBox(height: AppSizes.spacingLG),
                    _buildActionButtons(),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: _buildPreviewSection(),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return SafeArea(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSizes.paddingXL),
              child: Form(
                key: _formKey,
                child: ResponsiveColumn(
                  children: [
                    _buildHeader(),
                    const SizedBox(height: AppSizes.spacingXL),
                    _buildAboutForm(),
                    const SizedBox(height: AppSizes.spacingXL),
                    _buildActionButtons(),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: _buildPreviewSection(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return ResponsiveContainer(
      mobilePadding: const EdgeInsets.all(AppSizes.paddingMD),
      desktopPadding: const EdgeInsets.all(AppSizes.paddingLG),
      child: ResponsiveRow(
        children: [
          Expanded(
            child: AppText.h3('About Management'),
          ),
          ResponsiveRow(
            children: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: _loadAboutData,
              ),
              const SizedBox(width: AppSizes.spacingSM),
              IconButton(
                icon: const Icon(Icons.save),
                onPressed: _saveAboutData,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAboutForm() {
    return ResponsiveColumn(
      spacing: AppSizes.spacingMD,
      children: [
        ResponsiveRow(
          children: [
            Expanded(
              flex: 2,
              child: AdminFormComponents.buildTextField(
                label: 'Full Name',
                controller: _nameController,
                hintText: 'Enter your full name',
                prefixIcon: Icons.person,
              ),
            ),
            const SizedBox(width: AppSizes.spacingMD),
            Expanded(
              flex: 1,
              child: AdminFormComponents.buildTextField(
                label: 'Professional Title',
                controller: _titleController,
                hintText: 'e.g. Senior Developer',
                prefixIcon: Icons.work,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.spacingMD),
        AdminFormComponents.buildTextArea(
          label: 'Bio',
          controller: _bioController,
          hintText: 'Tell us about yourself...',
          maxLines: 4,
        ),
        const SizedBox(height: AppSizes.spacingMD),
        ResponsiveRow(
          children: [
            Expanded(
              child: AdminFormComponents.buildTextField(
                label: 'Email',
                controller: _emailController,
                hintText: 'contact@example.com',
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(width: AppSizes.spacingMD),
            Expanded(
              child: AdminFormComponents.buildTextField(
                label: 'Phone',
                controller: _phoneController,
                hintText: '+1 (555) 123-4567',
                prefixIcon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.spacingMD),
        AdminFormComponents.buildTextField(
          label: 'Location',
          controller: _locationController,
          hintText: 'City, Country',
          prefixIcon: Icons.location_on,
        ),
        const SizedBox(height: AppSizes.spacingMD),
        ResponsiveRow(
          children: [
            Expanded(
              child: AdminFormComponents.buildTextField(
                label: 'Website',
                controller: _websiteController,
                hintText: 'https://yourwebsite.com',
                prefixIcon: Icons.language,
                keyboardType: TextInputType.url,
              ),
            ),
            const SizedBox(width: AppSizes.spacingMD),
            Expanded(
              child: AdminFormComponents.buildTextField(
                label: 'LinkedIn',
                controller: _linkedinController,
                hintText: 'linkedin.com/in/yourprofile',
                prefixIcon: Icons.link,
                keyboardType: TextInputType.url,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.spacingMD),
        ResponsiveRow(
          children: [
            Expanded(
              child: AdminFormComponents.buildTextField(
                label: 'GitHub',
                controller: _githubController,
                hintText: 'github.com/yourusername',
                prefixIcon: Icons.code,
                keyboardType: TextInputType.url,
              ),
            ),
            const SizedBox(width: AppSizes.spacingMD),
            Expanded(
              child: AdminFormComponents.buildImagePicker(
                label: 'Resume',
                imageUrl: _resumeController.text,
                onPickImage: () {
                  // TODO: Implement resume picker
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return ResponsiveRow(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: _clearForm,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingLG,
                vertical: AppSizes.paddingMD,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusMD),
              ),
            ),
            child: AppText.medium('Clear'),
          ),
        ),
        const SizedBox(width: AppSizes.spacingMD),
        Expanded(
          child: ElevatedButton(
            onPressed: _isLoading ? null : _saveAboutData,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingLG,
                vertical: AppSizes.paddingMD,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusMD),
              ),
            ),
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : AppText.medium('Save About'),
          ),
        ),
      ],
    );
  }

  Widget _buildPreviewSection() {
    return ResponsiveContainer(
      mobilePadding: const EdgeInsets.all(AppSizes.paddingMD),
      desktopPadding: const EdgeInsets.all(AppSizes.paddingLG),
      child: ResponsiveColumn(
        children: [
          AppText.h3('Preview'),
          const SizedBox(height: AppSizes.spacingMD),
          ResponsiveContainer(
            mobileDecoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSizes.radiusMD),
              border: Border.all(color: AppColors.grey300),
            ),
            desktopDecoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSizes.radiusLG),
              border: Border.all(color: AppColors.grey300),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.paddingLG),
              child: ResponsiveColumn(
                children: [
                  if (_nameController.text.isNotEmpty)
                    _buildPreviewItem('Name', _nameController.text),
                  if (_titleController.text.isNotEmpty)
                    _buildPreviewItem('Title', _titleController.text),
                  if (_bioController.text.isNotEmpty)
                    _buildPreviewItem('Bio', _bioController.text),
                  if (_emailController.text.isNotEmpty)
                    _buildPreviewItem('Email', _emailController.text),
                  if (_phoneController.text.isNotEmpty)
                    _buildPreviewItem('Phone', _phoneController.text),
                  if (_locationController.text.isNotEmpty)
                    _buildPreviewItem('Location', _locationController.text),
                  if (_websiteController.text.isNotEmpty)
                    _buildPreviewItem('Website', _websiteController.text),
                  if (_linkedinController.text.isNotEmpty)
                    _buildPreviewItem('LinkedIn', _linkedinController.text),
                  if (_githubController.text.isNotEmpty)
                    _buildPreviewItem('GitHub', _githubController.text),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.spacingSM),
      child: ResponsiveContainer(
        child: ResponsiveColumn(
          children: [
            AppText.label(label),
            const SizedBox(height: AppSizes.spacingXS),
            AppText.medium(value),
          ],
        ),
      ),
    );
  }

  void _clearForm() {
    _nameController.clear();
    _titleController.clear();
    _bioController.clear();
    _emailController.clear();
    _phoneController.clear();
    _locationController.clear();
    _websiteController.clear();
    _linkedinController.clear();
    _githubController.clear();
    _resumeController.clear();
  }

  void _loadAboutData() {
    // TODO: Load existing about data from API/storage
    _nameController.text = 'John Doe';
    _titleController.text = 'Senior Flutter Developer';
    _bioController.text = 'Experienced Flutter developer with a passion for creating beautiful and functional mobile applications.';
    _emailController.text = 'john.doe@example.com';
    _phoneController.text = '+1 (555) 123-4567';
    _locationController.text = 'San Francisco, CA';
    _websiteController.text = 'https://johndoe.dev';
    _linkedinController.text = 'https://linkedin.com/in/johndoe';
    _githubController.text = 'https://github.com/johndoe';
  }

  Future<void> _saveAboutData() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      // TODO: Save about data to API/storage
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      // TODO: Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('About information saved successfully!'),
          backgroundColor: AppColors.success,
        ),
      );
    }
  }
}
