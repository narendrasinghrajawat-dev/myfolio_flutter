import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/responsive_builder.dart';
import '../../../../core/widgets/responsive_container.dart';
import '../../../../core/widgets/responsive_row.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
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
              _buildLoginForm(),
              const SizedBox(height: AppSizes.spacingMD),
              _buildSubmitButton(),
              const SizedBox(height: AppSizes.spacingMD),
              _buildRegisterLink(),
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
          constraints: const BoxConstraints(maxWidth: 400),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.paddingLG),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildHeader(),
                  const SizedBox(height: AppSizes.spacingXL),
                  _buildLoginForm(),
                  const SizedBox(height: AppSizes.spacingMD),
                  _buildSubmitButton(),
                  const SizedBox(height: AppSizes.spacingMD),
                  _buildRegisterLink(),
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
          constraints: const BoxConstraints(maxWidth: 400),
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
                    _buildLoginForm(),
                    const SizedBox(height: AppSizes.spacingMD),
                    _buildSubmitButton(),
                    const SizedBox(height: AppSizes.spacingMD),
                    _buildRegisterLink(),
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
        AppText.h1(AppStrings.login),
        const SizedBox(height: AppSizes.spacingSM),
        AppText.medium(
          'Welcome back! Please sign in to continue.',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return ResponsiveColumn(
      spacing: AppSizes.spacingMD,
      children: [
        _buildEmailField(),
        const SizedBox(height: AppSizes.spacingMD),
        _buildPasswordField(),
        const SizedBox(height: AppSizes.spacingSM),
        _buildForgotPasswordLink(),
      ],
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
          labelText: AppStrings.email,
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
          if (value == null || value!.isEmpty) {
            return AppStrings.requiredField;
          }
          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
            return AppStrings.invalidEmail;
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
          labelText: AppStrings.password,
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
          if (value == null || value!.isEmpty) {
            return AppStrings.requiredField;
          }
          if (value.length < 6) {
            return AppStrings.minLength;
          }
          return null;
        },
      ),
    );
  }

  Widget _buildForgotPasswordLink() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // TODO: Implement forgot password
        },
        child: AppText.small(
          AppStrings.forgotPassword,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Consumer(
      builder: (context, ref) {
        final authState = ref.watch(authStateProvider);
        
        return ResponsiveContainer(
          mobilePadding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingSM),
          desktopPadding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMD),
          child: SizedBox(
            width: double.infinity,
            height: AppSizes.buttonHeight,
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
                  : AppText.button(AppStrings.login),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRegisterLink() {
    return ResponsiveRow(
      alignment: MainAxisAlignment.center,
      children: [
        AppText.small('Don\'t have an account? '),
        TextButton(
          onPressed: () {
            // TODO: Navigate to register
          },
          child: AppText.small(
            AppStrings.register,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final notifier = ref.read(authNotifierProvider.notifier);
      await notifier.signInWithEmail(
        _emailController.text.trim(),
        _passwordController.text,
      );
    }
  }
}
