
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/meditation.dart';
import '../providers/music_provider.dart';

class MeditationPlayerScreen extends HookWidget {
  final Meditation meditation;
  final Duration duration;
  final String? musicTitle;

  const MeditationPlayerScreen({super.key, required this.meditation, required this.duration, this.musicTitle});

  @override
  Widget build(BuildContext context) {
    final musicProvider = Provider.of<MusicProvider>(context, listen: false);
    final remainingTime = useState(duration);
    final isPlaying = useState(true);
    final timer = useRef<Timer?>(null);
    final pageController = usePageController();
    final images = [
      'https://images.unsplash.com/photo-1518837695005-2083093ee35b?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?q=80&w=2071&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'https://images.unsplash.com/photo-1475113548554-5a36f1f523d6?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'https://images.unsplash.com/photo-1433838552652-f9a46b332c40?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ];

    void startTimer() {
      timer.value = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (remainingTime.value.inSeconds > 0) {
          remainingTime.value = remainingTime.value - const Duration(seconds: 1);
        } else {
          timer.cancel();
          isPlaying.value = false;
        }
      });
    }

    useEffect(() {
      if (musicTitle != null) {
        musicProvider.play(musicTitle!);
      }
      startTimer();

      final slideshowTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
        if (pageController.hasClients) {
            if (pageController.page == images.length - 1) {
                pageController.animateToPage(0, duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
            } else {
                pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
            }
        }
      });

      return () {
        timer.value?.cancel();
        slideshowTimer.cancel();
        musicProvider.stop();
      };
    }, []);

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Image.network(
                images[index],
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              );
            },
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(128),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(meditation.title, style: GoogleFonts.montserrat(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white, size: 30),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '${(remainingTime.value.inMinutes).toString().padLeft(2, '0')}:${(remainingTime.value.inSeconds % 60).toString().padLeft(2, '0')}',
                        style: GoogleFonts.montserrat(color: Colors.white, fontSize: 72, fontWeight: FontWeight.w100),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(isPlaying.value ? Icons.pause_circle_filled_rounded : Icons.play_circle_filled_rounded, color: Colors.white, size: 80),
                            onPressed: () {
                              if (isPlaying.value) {
                                timer.value?.cancel();
                                musicProvider.pause();
                              } else {
                                startTimer();
                                if (musicTitle != null) {
                                  musicProvider.play(musicTitle!);
                                }
                              }
                              isPlaying.value = !isPlaying.value;
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (musicTitle != null)
                    Consumer<MusicProvider>(
                      builder: (context, provider, child) {
                        return Row(
                          children: [
                            const Icon(Icons.volume_up_rounded, color: Colors.white),
                            Expanded(
                              child: Slider(
                                value: provider.volume,
                                onChanged: (value) => provider.setVolume(value),
                                activeColor: Colors.white,
                                inactiveColor: Colors.white.withAlpha(128),
                              ),
                            ),
                          ],
                        );
                      },
                    )
                  else
                    const SizedBox(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
