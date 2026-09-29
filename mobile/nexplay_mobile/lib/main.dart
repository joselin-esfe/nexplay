import 'package:flutter/material.dart';

import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'features/games/games_screen.dart';
import 'features/home/home_screen.dart';
import 'features/profile/profile_screen.dart';
import 'features/login/login_screen.dart';
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

      // La aplicación siempre inicia en Splash.
      initialRoute: AppRoutes.splash,

      routes: {
        // Pantallas de Paola
        AppRoutes.splash: (_) => const SplashScreen(),
        AppRoutes.register: (_) => const RegisterScreen(),

        // Pantallas de Joselin
        AppRoutes.login: (_) => const LoginScreen(),
        AppRoutes.home: (_) => const HomeScreen(),
        AppRoutes.games: (_) => const GamesScreen(),
        AppRoutes.profile: (_) => const ProfileScreen(),
      },

      // Crear Perfil necesita recibir los datos del usuario registrado,
      // por eso se genera la ruta de manera dinámica.
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
