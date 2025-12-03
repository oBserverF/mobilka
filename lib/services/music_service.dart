import '../models/music.dart';

/// Сервис для получения списка фоновой музыки.
class MusicService {
  Future<List<Music>> getMusic() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      Music(id: 'rain', title: 'Дождь', path: 'assets/audio/rain.mp3'),
      Music(id: 'forest', title: 'Лес', path: 'assets/audio/forest.mp3'),
      Music(id: 'ocean', title: 'Океан', path: 'assets/audio/ocean.mp3'),
      Music(id: 'cafe', title: 'Кафе', path: 'assets/audio/cafe.mp3', isPremium: true),
      Music(id: 'river', title: 'Река', path: 'assets/audio/river.mp3', isPremium: true),
    ];
  }
}
