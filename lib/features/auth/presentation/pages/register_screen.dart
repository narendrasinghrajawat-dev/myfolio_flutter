import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/responsive_builder.dart';
import '../controllers/auth_controller.dart';
  

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _displayNameController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _displayNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: ResponsiveBuilder(
        mobile: _buildMobileLayout(context),
        tablet: _buildTabletLayout(context),
        desktop: _buildDesktopLayout(context),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.paddingMD),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSizes.spacingXL),
              _buildHeader(),
              const SizedBox(height: AppSizes.spacingXL),
              _buildRegisterForm(),
              const SizedBox(height: AppSizes.spacingMD),
              _buildSubmitButton(),
              const SizedBox(height: AppSizes.spacingMD),
              _buildLoginLink(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.paddingLG),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildHeader(),
                  const SizedBox(height: AppSizes.spacingXL),
                  _buildRegisterForm(),
                  const SizedBox(height: AppSizes.spacingMD),
                  _buildSubmitButton(),
                  const SizedBox(height: AppSizes.spacingMD),
                  _buildLoginLink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Card(
            elevation: AppSizes.elevationLG,
            shadowColor: AppColors.grey300,
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.paddingXL),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: AppSizes.spacingXL),
                    _buildRegisterForm(),
                    const SizedBox(height: AppSizes.spacingMD),
                    _buildSubmitButton(),
                    const SizedBox(height: AppSizes.spacingMD),
                    _buildLoginLink(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return ResponsiveColumn(
      children: [
        AppText.h1(AppStrings.authRegister),
        const SizedBox(height: AppSizes.spacingSM),
        AppText.medium(
          'Create your account to get started',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildRegisterForm() {
    return ResponsiveColumn(
      spacing: AppSizes.spacingMD,
      children: [
        _buildDisplayNameField(),
        _buildEmailField(),
        _buildPasswordField(),
        _buildConfirmPasswordField(),
      ],
    );
  }

  Widget _buildDisplayNameField() {
    return ResponsiveContainer(
      mobilePadding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingSM),
      desktopPadding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMD),
      child: TextFormField(
        controller: _displayNameController,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          labelText: AppStrings.authDisplayName,
          hintText: 'Enter your display name',
          prefixIcon: const Icon(Icons.person_outlined),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMD),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMD),
            borderSide: const BorderSide(color: AppColors.primary),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return AppStrings.fieldRequired;
          }
          if (value.length < 2) {
            return 'Display name must be at least 2 characters';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildEmailField() {
    return ResponsiveContainer(
      mobilePadding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingSM),
      desktopPadding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMD),
      child: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: AppStrings.authEmail,
          hintText: 'Enter your email',
          prefixIcon: const Icon(Icons.email_outlined),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMD),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMD),
            borderSide: const BorderSide(color: AppColors.primary),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return AppStrings.fieldRequired;
          }
          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
            return AppStrings.fieldInvalidEmail;
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordField() {
    return ResponsiveContainer(
      mobilePadding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingSM),
      desktopPadding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMD),
      child: TextFormField(
        controller: _passwordController,
        obscureText: _obscurePassword,
        decoration: InputDecoration(
          labelText: AppStrings.authPassword,
          hintText: 'Enter your password',
          prefixIcon: const Icon(Icons.lock_outlined),
          suffixIcon: IconButton(
            icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMD),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMD),
            borderSide: const BorderSide(color: AppColors.primary),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return AppStrings.fieldRequired;
          }
          if (value.length < 6) {
            return AppStrings.fieldInvalidPassword;
          }
          return null;
        },
      ),
    );
  }

  Widget _buildConfirmPasswordField() {
    return ResponsiveContainer(
      mobilePadding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingSM),
      desktopPadding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMD),
      child: TextFormField(
        controller: _confirmPasswordController,
        obscureText: _obscureConfirmPassword,
        decoration: InputDecoration(
          labelText: AppStrings.authConfirmPassword,
          hintText: 'Confirm your password',
          prefixIcon: const Icon(Icons.lock_outlined),
          suffixIcon: IconButton(
            icon: Icon(_obscureConfirmPassword ? Icons.visibility_off : Icons.visibility),
            onPressed: () {
              setState(() {
                _obscureConfirmPassword = !_obscureConfirmPassword;
              });
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMD),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMD),
            borderSide: const BorderSide(color: AppColors.primary),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return AppStrings.fieldRequired;
          }
          if (value != _passwordController.text) {
            return 'Passwords do not match';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Consumer(
      builder: (context, ref, child) {
        final authState = ref.watch(authControllerProvider);
        
        return ResponsiveContainer(
          mobilePadding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingSM),
          desktopPadding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMD),
          child: SizedBox(
            width: double.infinity,
            height: AppSizes.buttonHeightMD,
            child: ElevatedButton(
              onPressed: authState.status == AuthStatus.loading ? null : _handleSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingLG),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusMD),
                ),
              ),
              child: authState.status == AuthStatus.loading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.onPrimary),
                      ),
                    )
                  : AppText.button(AppStrings.authCreateAccount),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoginLink() {
    return ResponsiveRow(
      mobileAlignment: MainAxisAlignment.center,
      tabletAlignment: MainAxisAlignment.center,
      desktopAlignment: MainAxisAlignment.center,
      children: [
        AppText.small('Already have an account? '),
        TextButton(
          onPressed: () {
            // TODO: Navigate to login
          },
          child: AppText.small(
            AppStrings.authSignInInstead,
            style: const TextStyle(color: AppColors.primary),
          ),
        ),
      ],
    );
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final notifier = ref.read(authControllerProvider.notifier);
      final displayName = _displayNameController.text.trim();
      final nameParts = displayName.split(' ');
      final firstName = nameParts.isNotEmpty ? nameParts[0] : '';
      final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';
      
      await notifier.register(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        firstName: firstName,
        lastName: lastName,
      );
    }
  }
}
