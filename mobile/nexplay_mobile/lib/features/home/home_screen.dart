import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.sports_esports_rounded, color: AppColors.primary, size: 26),
            SizedBox(width: 8),
            Text('NEXPLAY', style: AppTextStyles.title),
          ],
        ),
        backgroundColor: AppColors.panel,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: AppColors.textPrimary),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Principal de Saludo y Nivel Gamer
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.panelAlt,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.border),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.35),
                    blurRadius: 14,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.panelLight,
                          border: Border.all(color: AppColors.primary, width: 2),
                        ),
                        child: const Center(
                          child: Icon(Icons.person_rounded, color: AppColors.primary, size: 28),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('¡HOLA, GAMER! 👋', style: AppTextStyles.title),
                            const SizedBox(height: 2),
                            Text(
                              'Nivel 12 • Competidor Pro',
                              style: AppTextStyles.bodySecondary,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.secondary.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.secondary.withValues(alpha: 0.5)),
                        ),
                        child: const Text(
                          'LVL 12',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Barra de Nivel
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('PROGRESO DE NIVEL', style: AppTextStyles.label),
                      const Text('1,250 / 2,000 XP', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primary)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: const LinearProgressIndicator(
                      value: 0.625,
                      minHeight: 8,
                      backgroundColor: AppColors.panelLight,
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Resumen de Stats
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.flash_on_rounded, color: AppColors.primary, size: 16),
                          const SizedBox(width: 4),
                          const Text('1,250 XP', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.monetization_on_rounded, color: AppColors.secondary, size: 16),
                          const SizedBox(width: 4),
                          const Text('850 Monedas', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.leaderboard_rounded, color: AppColors.secondary, size: 16),
                          const SizedBox(width: 4),
                          const Text('Rank #4', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.secondary)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Encabezado del Panel de Módulos
            const Text('PANEL DE NAVEGACIÓN', style: AppTextStyles.label),
            const SizedBox(height: 14),

            // Tarjeta 1: RETOS Y DESAFÍOS
            _buildDashboardCard(
              context,
              title: 'RETOS Y DESAFÍOS',
              subtitle: 'Supera las misiones diarias, gana XP y desbloquea recompensas.',
              icon: Icons.emoji_events_rounded,
              iconColor: AppColors.primary,
              buttonText: 'EXPLORAR RETOS',
              route: AppRoutes.retos,
            ),
            const SizedBox(height: 16),

            // Tarjeta 2: LOGROS Y MEDALLAS
            _buildDashboardCard(
              context,
              title: 'LOGROS Y MEDALLAS',
              subtitle: 'Consulta tus insignias desbloqueadas y metas alcanzadas.',
              icon: Icons.military_tech_rounded,
              iconColor: AppColors.secondary,
              buttonText: 'VER MEDALLAS',
              route: AppRoutes.logros,
            ),
            const SizedBox(height: 16),

            // Tarjeta 3: RANKING Y CLASIFICACIÓN
            _buildDashboardCard(
              context,
              title: 'RANKING Y TABLA',
              subtitle: 'Compite en las ligas semanal, mensual y global para llegar al Top 3.',
              icon: Icons.leaderboard_rounded,
              iconColor: AppColors.primary,
              buttonText: 'VER CLASIFICACIÓN',
              route: AppRoutes.ranking,
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required String buttonText,
    required String route,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.panel,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: iconColor.withValues(alpha: 0.4)),
                ),
                child: Icon(icon, color: iconColor, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTextStyles.title),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: AppTextStyles.bodySecondary,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: iconColor == AppColors.secondary ? AppColors.secondary : AppColors.primary,
                foregroundColor: iconColor == AppColors.secondary ? Colors.black : AppColors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 2,
              ),
              onPressed: () => Navigator.of(context).pushNamed(route),
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                  color: iconColor == AppColors.secondary ? Colors.black : AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
