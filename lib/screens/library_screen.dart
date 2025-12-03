
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/music_service.dart';
import '../models/music.dart';

class LibraryScreen extends HookWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final musicService = useMemoized(() => MusicService());
    final musicListFuture = useMemoized(() => musicService.getMusic(), []);
    final snapshot = useFuture(musicListFuture);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Фоновая музыка'),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: _buildBody(context, snapshot),
      ),
    );
  }

  Widget _buildBody(BuildContext context, AsyncSnapshot<List<Music>> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(key: ValueKey('loading'), child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Center(key: const ValueKey('error'), child: Text('Ошибка: ${snapshot.error}'));
    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return const Center(key: ValueKey('empty'), child: Text('Нет доступной музыки'));
    } else {
      final musicList = snapshot.data!;
      return GridView.builder(
        key: const ValueKey('data'),
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        itemCount: musicList.length,
        itemBuilder: (context, index) {
          final music = musicList[index];
          return _buildMusicCard(context, music);
        },
      );
    }
  }

  Widget _buildMusicCard(BuildContext context, Music music) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        if (music.isPremium) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Эта музыка будет доступна в будущем!', style: GoogleFonts.montserrat(color: Colors.white)),
              backgroundColor: theme.colorScheme.secondary,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          );
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: NetworkImage('https://picsum.photos/seed/${music.id}/300/400'),
            fit: BoxFit.cover,
            colorFilter: music.isPremium ? ColorFilter.mode(Colors.black.withAlpha(128), BlendMode.darken) : null,
          ),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withAlpha(179)],
                ),
              ),
            ),
            if (music.isPremium)
              const Center(
                child: Icon(Icons.lock_rounded, color: Colors.white, size: 40),
              ),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Text(
                music.title,
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
