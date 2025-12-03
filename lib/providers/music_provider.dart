
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import '../models/music.dart';

class MusicProvider with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final List<Music> _musicTracks = [
    Music(title: 'Forest', path: 'assets/audio/forest.mp3'),
    Music(title: 'Ocean', path: 'assets/audio/ocean.mp3'),
    Music(title: 'Rain', path: 'assets/audio/rain.mp3'),
  ];

  String? _currentTrack;
  double _volume = 0.5;
  bool _isPlaying = false;

  List<Music> get musicTracks => _musicTracks;
  double get volume => _volume;
  bool get isPlaying => _isPlaying;
  String? get currentTrack => _currentTrack;

  MusicProvider() {
    _audioPlayer.playerStateStream.listen((playerState) {
      _isPlaying = playerState.playing;
      if (playerState.processingState == ProcessingState.completed) {
        _currentTrack = null;
        _isPlaying = false;
      }
      notifyListeners();
    });
  }

  Future<void> play(String title) async {
    final music = _musicTracks.firstWhere((m) => m.title == title);
    if (_currentTrack == title && _isPlaying) return;
    
    _currentTrack = title;
    
    try {
      final audioSource = AudioSource.asset(
        music.path,
        tag: MediaItem(
          id: music.path,
          title: music.title,
        ),
      );
      await _audioPlayer.setAudioSource(audioSource);
      await _audioPlayer.setVolume(_volume);
      _audioPlayer.play();

    } catch (e) {
      print("Error playing audio in MusicProvider: $e");
    }
    notifyListeners();
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
    notifyListeners();
  }

  Future<void> resume() async {
    await _audioPlayer.play();
    notifyListeners();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    _currentTrack = null;
    notifyListeners();
  }

  Future<void> setVolume(double vol) async {
    _volume = vol;
    await _audioPlayer.setVolume(_volume);
    notifyListeners();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
