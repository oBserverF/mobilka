
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/meditation.dart';
import '../screens/meditation_player_screen.dart';

class MeditationStartSheet extends HookWidget {
  final Meditation meditation;

  const MeditationStartSheet({super.key, required this.meditation});

  @override
  Widget build(BuildContext context) {
    final selectedDuration = useState(const Duration(minutes: 10));
    final durations = [5, 10, 15, 20, 30].map((m) => Duration(minutes: m)).toList();
    final theme = Theme.of(context);

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface.withAlpha(217),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              meditation.title,
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              meditation.description,
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.textTheme.bodyMedium?.color?.withAlpha(179)),
            ),
            const SizedBox(height: 24),
            Text('Длительность', style: theme.textTheme.titleMedium),
            const SizedBox(height: 16),
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: durations.length,
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final duration = durations[index];
                  final isSelected = duration == selectedDuration.value;
                  return ChoiceChip(
                    label: Text('${duration.inMinutes} мин'),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        selectedDuration.value = duration;
                      }
                    },
                    backgroundColor: theme.colorScheme.secondary.withAlpha(128),
                    selectedColor: theme.colorScheme.primary,
                    labelStyle: TextStyle(
                      color: isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.onSecondary,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide.none,
                    ),
                    elevation: isSelected ? 3 : 0,
                  );
                },
              ),
            ),
            const SizedBox(height: 32),
            _buildStartButton(context, theme, selectedDuration.value),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildStartButton(BuildContext context, ThemeData theme, Duration duration) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context); // Close sheet
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MeditationPlayerScreen(meditation: meditation, duration: duration),
            fullscreenDialog: true,
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.primary.withAlpha(102),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            'Начать',
            style: GoogleFonts.montserrat(
              color: theme.colorScheme.onPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
