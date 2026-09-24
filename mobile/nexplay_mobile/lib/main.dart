import 'package:flutter/material.dart';

import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'features/profile_creation/profile_creation_screen.dart';
import 'features/register/register_screen.dart';
import 'features/splash/splash_screen.dart';

void main() {
  runApp(const NexPlayApp());
}

class NexPlayApp extends StatelessWidget {
  const NexPlayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NEXPLAY',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (_) => const SplashScreen(),
        AppRoutes.register: (_) => const RegisterScreen(),
        AppRoutes.loginPlaceholder: (_) => const _LoginPlaceholderScreen(),
        AppRoutes.homePlaceholder: (_) => const _HomePlaceholderScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == AppRoutes.profileCreation) {
          final arguments = settings.arguments as Map<String, dynamic>?;
          return MaterialPageRoute(
            builder: (_) => ProfileCreationScreen(
              userData: arguments ?? const <String, dynamic>{},
            ),
          );
        }
        return null;
      },
    );
  }
}

class _LoginPlaceholderScreen extends StatelessWidget {
  const _LoginPlaceholderScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Login pendiente')));
  }
}

class _HomePlaceholderScreen extends StatelessWidget {
  const _HomePlaceholderScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Home pendiente')));
  }
}
