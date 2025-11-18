
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Доброе утро, Пользователь', style: theme.textTheme.titleLarge),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildQuickStartCard(context, theme),
              const SizedBox(height: 30),
              Text('Рекомендуемые', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 15),
              _buildFeaturedSection(theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickStartCard(BuildContext context, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary.withAlpha(204),
            theme.colorScheme.secondary.withAlpha(204),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withAlpha(77),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Начните день правильно',
                  style: GoogleFonts.montserrat(
                    color: theme.colorScheme.onPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '10-минутная утренняя медитация',
                  style: GoogleFonts.montserrat(
                    color: theme.colorScheme.onPrimary.withAlpha(204),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Icon(Icons.play_circle_fill_rounded, color: Colors.white, size: 50),
        ],
      ),
    );
  }

  Widget _buildFeaturedSection(ThemeData theme) {
    return SizedBox(
      height: 160,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildFeaturedCard(theme, 'Релаксация', Icons.self_improvement, const Color(0xFFC9E8D3), const Color(0xFFA3D9B1)),
          const SizedBox(width: 15),
          _buildFeaturedCard(theme, 'Фокус', Icons.center_focus_strong, const Color(0xFFD4E5F1), const Color(0xFFA9CBE5)),
          const SizedBox(width: 15),
          _buildFeaturedCard(theme, 'Сон', Icons.bedtime, const Color(0xFFE3D4F1), const Color(0xFFC3A9E5)),
        ],
      ),
    );
  }

  Widget _buildFeaturedCard(ThemeData theme, String title, IconData icon, Color startColor, Color endColor) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [startColor, endColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(icon, color: Colors.white, size: 30),
          const Spacer(),
          Text(
            title,
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
