import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/constants/app_constants.dart';
import 'core/services/api_service.dart';
import 'core/services/theme_service.dart';
import 'core/services/localization_service.dart';
import 'core/themes/app_theme.dart';
import 'features/auth/presentation/auth_notifier.dart';
import 'features/portfolio/presentation/pages/portfolio_page.dart';
import 'features/admin/presentation/pages/admin_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final themeState = ref.watch(themeStateProvider);
    final localizationState = ref.watch(localizationStateProvider);
    
    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      routerConfig: GoRouter(
        navigatorKey: navigatorKey,
        initialLocation: authState.status == AuthStatus.authenticated 
            ? '/portfolio' 
            : '/login',
        routes: [
          // Auth Routes
          GoRoute(
            path: '/login',
            builder: (context, state) => const LoginPage(),
          ),
          GoRoute(
            path: '/register',
            builder: (context, state) => const RegisterScreen(),
          ),
          
          // Main App Routes
          GoRoute(
            path: '/portfolio',
            builder: (context, state) => const PortfolioPage(),
          ),
          GoRoute(
            path: '/projects',
            builder: (context, state) => const ProjectListScreen(),
          ),
          GoRoute(
            path: '/add-project',
            builder: (context, state) => const AddProjectScreen(),
          ),
          GoRoute(
            path: '/skills',
            builder: (context, state) => const SkillsScreen(),
          ),
          GoRoute(
            path: '/education',
            builder: (context, state) => const EducationScreen(),
          ),
          GoRoute(
            path: '/about',
            builder: (context, state) => const AboutScreen(),
          ),
          GoRoute(
            path: AppConstants.adminRoute,
            builder: (context, state) => const AdminPage(),
          ),
        ],
      ),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _getThemeMode(themeState.mode),
      locale: localizationState.locale,
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('hi', 'IN'),
      ],
      localizationsDelegates: const [
        // Add actual localization delegates here
      ],
    );
  }
  
  ThemeMode _getThemeMode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return ThemeMode.light;
      case ThemeMode.dark:
        return ThemeMode.dark;
      case ThemeMode.system:
        return ThemeMode.system;
    }
  }
}

// Initialize SharedPreferences provider
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});
