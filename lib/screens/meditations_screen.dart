
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../services/meditation_service.dart';
import '../models/meditation.dart';
import '../widgets/meditation_start_sheet.dart';
import 'package:google_fonts/google_fonts.dart';

class MeditationsScreen extends HookWidget {
  const MeditationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final meditationService = useMemoized(() => MeditationService());
    final meditationsFuture = useMemoized(() => meditationService.getMeditations(), []);
    final snapshot = useFuture(meditationsFuture);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Практики'),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: _buildBody(context, snapshot),
      ),
    );
  }

  Widget _buildBody(BuildContext context, AsyncSnapshot<List<Meditation>> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(key: ValueKey('loading'), child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Center(key: const ValueKey('error'), child: Text('Ошибка: ${snapshot.error}'));
    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return const Center(key: ValueKey('empty'), child: Text('Нет доступных медитаций'));
    } else {
      final meditations = snapshot.data!;
      return ListView.builder(
        key: const ValueKey('data'),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        itemCount: meditations.length,
        itemBuilder: (context, index) {
          final meditation = meditations[index];
          return _buildMeditationCard(context, meditation);
        },
      );
    }
  }

  Widget _buildMeditationCard(BuildContext context, Meditation meditation) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          builder: (context) => MeditationStartSheet(meditation: meditation),
        );
      },
      child: Container(
        height: 150,
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: NetworkImage('https://picsum.photos/seed/${meditation.id}/400/200'), // Placeholder image
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(26),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withAlpha(26),
                Colors.black.withAlpha(153),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                meditation.title,
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                meditation.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.montserrat(
                  color: Colors.white.withAlpha(230),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
