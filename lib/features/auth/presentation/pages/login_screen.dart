import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/widgets/common_text.dart';
import '../../../../core/widgets/common_text_field.dart';
import '../../../../core/widgets/common_button.dart';
import '../../../../core/widgets/responsive_layout.dart';
import '../../../../core/config/app_theme_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../controllers/auth_controller.dart';

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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      backgroundColor: AppThemeColors.lightBackground,
      body: ResponsiveContainer(
        center: true,
        useCard: true,
        backgroundColor: AppThemeColors.lightSurface,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const ResponsiveSpacing(mobile: AppSizes.spacingXL),
              _buildHeader(),
              const ResponsiveSpacing(mobile: AppSizes.spacingXL),
              _buildEmailField(),
              const ResponsiveSpacing(mobile: AppSizes.spacingMD),
              _buildPasswordField(),
              if (authState.hasError && authState.errorMessage != null) ...[
                const ResponsiveSpacing(mobile: AppSizes.spacingSM),
                CommonText.verySmall(
                  authState.errorMessage!,
                  color: AppThemeColors.error,
                ),
              ],
              const ResponsiveSpacing(mobile: AppSizes.spacingSM),
              _buildForgotPasswordLink(),
              const ResponsiveSpacing(mobile: AppSizes.spacingLG),
              _buildLoginButton(authState),
              const ResponsiveSpacing(mobile: AppSizes.spacingMD),
              _buildRegisterLink(),
              const ResponsiveSpacing(mobile: AppSizes.spacingXL),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        CommonText.veryLarge(
          l10n.authWelcome,
          fontWeight: FontWeight.bold,
        ),
        const ResponsiveSpacing(mobile: AppSizes.spacingSM),
        CommonText.small(
          l10n.appName,
          color: AppThemeColors.grey600,
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    final l10n = AppLocalizations.of(context)!;
    return CommonTextField(
      controller: _emailController,
      labelText: l10n.authEmail,
      hintText: 'Enter your email',
      prefixIcon: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return l10n.fieldRequired;
        }
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return l10n.fieldInvalidEmail;
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    final l10n = AppLocalizations.of(context)!;
    return CommonTextField(
      controller: _passwordController,
      labelText: l10n.authPassword,
      hintText: 'Enter your password',
      prefixIcon: Icons.lock_outline,
      suffixIcon: _obscurePassword ? Icons.visibility_off : Icons.visibility,
      onSuffixIconPressed: () {
        setState(() {
          _obscurePassword = !_obscurePassword;
        });
      },
      obscureText: _obscurePassword,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return l10n.fieldRequired;
        }
        if (value.length < 8) {
          return l10n.fieldInvalidPassword;
        }
        return null;
      },
    );
  }

  Widget _buildForgotPasswordLink() {
    final l10n = AppLocalizations.of(context)!;
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // TODO: Implement forgot password
        },
        child: CommonText.small(
          l10n.authForgotPassword,
          color: AppThemeColors.primary,
        ),
      ),
    );
  }

  Widget _buildLoginButton(dynamic authState) {
    final l10n = AppLocalizations.of(context)!;
    return CommonButton(
      text: l10n.authLogin,
      onPressed: authState.isLoading ? null : _handleSubmit,
      isLoading: authState.isLoading,
      type: CommonButtonType.primary,
      size: CommonButtonSize.large,
    );
  }

  Widget _buildRegisterLink() {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CommonText.small(
          l10n.authAlreadyHaveAccount,
        ),
        TextButton(
          onPressed: () {
            // TODO: Navigate to register
          },
          child: CommonText.small(
            l10n.authRegister,
            color: AppThemeColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final controller = ref.read(authControllerProvider.notifier);
      final success = await controller.login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (success && mounted) {
        // Navigate to home/portfolio
        // TODO: Implement navigation
      }
    }
  }
}
