import 'package:flutter/material.dart';
import '../models/music.dart';

/// Провайдер для управления состоянием фоновой музыки.
class MusicProvider with ChangeNotifier {
  Music? _selectedMusic;

  Music? get selectedMusic => _selectedMusic;

  void selectMusic(Music music) {
    _selectedMusic = music;
    notifyListeners(); // Уведомляем слушателей об изменении
  }
}
