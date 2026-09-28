import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('NEXPLAY'),
        backgroundColor: AppColors.surface,
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () => Navigator.of(context).pushNamed(AppRoutes.games),
          icon: const Icon(Icons.sports_esports_rounded),
          label: const Text('EXPLORAR JUEGOS'),
        ),
      ),
    );
  }
}
