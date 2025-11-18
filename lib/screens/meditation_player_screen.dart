
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/meditation.dart';
import '../providers/music_provider.dart';

class MeditationPlayerScreen extends HookWidget {
  final Meditation meditation;
  final Duration duration;

  const MeditationPlayerScreen({super.key, required this.meditation, required this.duration});

  @override
  Widget build(BuildContext context) {
    final audioPlayer = useMemoized(() => AudioPlayer(), []);
    final backgroundPlayer = useMemoized(() => AudioPlayer(), []);
    final isPlaying = useState(false);
    final remainingTime = useState(duration);
    final timer = useRef<Timer?>(null);
    final theme = Theme.of(context);

    final musicProvider = Provider.of<MusicProvider>(context, listen: false);
    final selectedMusic = musicProvider.selectedMusic;

    void startTimer() {
      timer.value?.cancel(); // Cancel any existing timer
      timer.value = Timer.periodic(const Duration(seconds: 1), (t) {
        if (remainingTime.value.inSeconds <= 0) {
          t.cancel();
          audioPlayer.stop();
          backgroundPlayer.stop();
          if (context.mounted) Navigator.pop(context);
        } else {
          remainingTime.value = remainingTime.value - const Duration(seconds: 1);
        }
      });
    }

    void playAudio() {
      audioPlayer.play(AssetSource(meditation.audioUrl));
      if (selectedMusic != null) {
        backgroundPlayer.play(AssetSource(selectedMusic.audioUrl));
        backgroundPlayer.setVolume(0.3);
      }
      isPlaying.value = true;
      startTimer();
    }

    void pauseAudio() {
      timer.value?.cancel();
      audioPlayer.pause();
      backgroundPlayer.pause();
      isPlaying.value = false;
    }

    void resumeAudio() {
      audioPlayer.resume();
      if (selectedMusic != null) backgroundPlayer.resume();
      isPlaying.value = true;
      startTimer();
    }

    useEffect(() {
      playAudio();
      return () {
        timer.value?.cancel();
        audioPlayer.dispose();
        backgroundPlayer.dispose();
      };
    }, []);

    String formatDuration(Duration d) {
      final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
      final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
      return '$minutes:$seconds';
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          _buildAnimatedBackground(theme),
          _buildGradientOverlay(),
          _buildContent(context, theme, formatDuration, remainingTime, isPlaying, pauseAudio, resumeAudio),
        ],
      ),
    );
  }

  Widget _buildAnimatedBackground(ThemeData theme) {
    return AnimatedContainer(
      duration: const Duration(seconds: 5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary.withAlpha(128),
            theme.colorScheme.secondary.withAlpha(128),
            Colors.black,
          ],
        ),
      ),
    );
  }

  Widget _buildGradientOverlay() {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 1.0,
          colors: [Colors.white.withAlpha(26), Colors.black.withAlpha(204)],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ThemeData theme, String Function(Duration) formatDuration, ValueNotifier<Duration> remainingTime, ValueNotifier<bool> isPlaying, VoidCallback pause, VoidCallback resume) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildHeader(context, theme),
            _buildTimerDisplay(theme, formatDuration, remainingTime),
            _buildControls(theme, isPlaying, pause, resume),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(meditation.title, style: GoogleFonts.montserrat(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            Text(meditation.description, style: GoogleFonts.montserrat(color: Colors.white70, fontSize: 16)),
          ],
        ),
        IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close, color: Colors.white, size: 30)),
      ],
    );
  }

  Widget _buildTimerDisplay(ThemeData theme, String Function(Duration) formatDuration, ValueNotifier<Duration> remainingTime) {
    final totalSeconds = duration.inSeconds;
    final remainingSeconds = remainingTime.value.inSeconds;
    final progress = totalSeconds > 0 ? (totalSeconds - remainingSeconds) / totalSeconds : 0.0;

    return SizedBox(
      width: 280,
      height: 280,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 280,
            height: 280,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 8,
              backgroundColor: Colors.white.withAlpha(26),
              valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
            ),
          ),
          Text(
            formatDuration(remainingTime.value),
            style: GoogleFonts.montserrat(color: Colors.white, fontSize: 60, fontWeight: FontWeight.w200),
          ),
        ],
      ),
    );
  }

  Widget _buildControls(ThemeData theme, ValueNotifier<bool> isPlaying, VoidCallback pause, VoidCallback resume) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: isPlaying.value ? pause : resume,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withAlpha(51),
              border: Border.all(color: Colors.white.withAlpha(77), width: 2),
            ),
            child: Icon(
              isPlaying.value ? Icons.pause_rounded : Icons.play_arrow_rounded,
              color: Colors.white,
              size: 60,
            ),
          ),
        ),
      ],
    );
  }
}
