
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/screens/chat_screen.dart';

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
              Text('Советы по медитации', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 15),
              _buildMeditationTipsSection(theme),
              const SizedBox(height: 30),
              Text('Помощь и ответы', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 15),
              _buildFaqSection(theme),
              const SizedBox(height: 30),
              _buildChatCard(context, theme),
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

  Widget _buildMeditationTipsSection(ThemeData theme) {
    return SizedBox(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildTipCard(theme, 'Найдите тихое место', Icons.airline_seat_legroom_reduced_rounded),
          const SizedBox(width: 15),
          _buildTipCard(theme, 'Следите за дыханием', Icons.air_rounded),
          const SizedBox(width: 15),
          _buildTipCard(theme, 'Будьте последовательны', Icons.all_inclusive_rounded),
        ],
      ),
    );
  }

  Widget _buildTipCard(ThemeData theme, String title, IconData icon) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 30),
          const Spacer(),
          Text(
            title,
            style: GoogleFonts.montserrat(
              color: theme.colorScheme.onSurface,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

    Widget _buildFaqSection(ThemeData theme) {
    return Column(
      children: [
        _buildFaqCard(theme, 'Как начать медитировать?', 'Начните с 5-10 минут в день, сидя в удобной позе и фокусируясь на дыхании.'),
        const SizedBox(height: 10),
        _buildFaqCard(theme, 'О чем думать во время медитации?', 'Старайтесь не думать ни о чем, просто наблюдайте за своими мыслями, не вовлекаясь в них.'),
      ],
    );
  }

  Widget _buildFaqCard(ThemeData theme, String question, String answer) {
    return Card(
      elevation: 2,
      shadowColor: theme.colorScheme.primary.withAlpha(50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ExpansionTile(
        title: Text(question, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(answer, style: theme.textTheme.bodyMedium),
          )
        ],
      ),
    );
  }

  Widget _buildChatCard(BuildContext context, ThemeData theme) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatScreen())),
      child: Card(
        elevation: 2,
        shadowColor: theme.colorScheme.primary.withAlpha(50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(Icons.chat_bubble_outline_rounded, color: theme.colorScheme.primary, size: 30),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Чат с ассистентом',
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Icon(Icons.lock_rounded, color: Colors.grey[400]),
            ],
          ),
        ),
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
