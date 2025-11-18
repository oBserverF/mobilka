import '../models/music.dart';

/// Сервис для получения списка фоновой музыки.
class MusicService {
  Future<List<Music>> getMusic() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      Music(id: 'rain', title: 'Дождь', audioUrl: 'assets/audio/rain.mp3'),
      Music(id: 'forest', title: 'Лес', audioUrl: 'assets/audio/forest.mp3'),
      Music(id: 'ocean', title: 'Океан', audioUrl: 'assets/audio/ocean.mp3'),
      Music(id: 'cafe', title: 'Кафе', audioUrl: 'assets/audio/cafe.mp3', isPremium: true),
      Music(id: 'river', title: 'Река', audioUrl: 'assets/audio/river.mp3', isPremium: true),
    ];
  }
}
