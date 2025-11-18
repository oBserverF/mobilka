import '../models/meditation.dart';

/// Сервисный слой для управления данными о медитациях.
///
/// В реальном приложении этот сервис будет взаимодействовать с API или базой данных.
/// Сейчас он имитирует получение данных с задержкой.
class MeditationService {
  /// Получает список всех медитаций.
  Future<List<Meditation>> getMeditations() async {
    // Имитация задержки сети
    await Future.delayed(const Duration(seconds: 1));

    // Возвращаем фиктивные данные
    return [
      Meditation(
        id: '1',
        title: 'Утренняя медитация',
        description: 'Начните свой день с позитивной энергией.',
        audioUrl: 'audio/morning_meditation.mp3',
        imageUrl: 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?q=80&w=2720&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      ),
      Meditation(
        id: '2',
        title: 'Дыхательная практика',
        description: 'Сконцентрируйтесь на своем дыхании и успокойте ум.',
        audioUrl: 'audio/breathing_practice.mp3',
        imageUrl: 'https://images.unsplash.com/photo-1506126613408-4e0e0f7c50e1?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      ),
      Meditation(
        id: '3',
        title: 'Вечернее расслабление',
        description: 'Подготовьтесь ко сну и снимите напряжение.',
        audioUrl: 'audio/evening_relaxation.mp3',
        imageUrl: 'https://images.unsplash.com/photo-1552193820-f4fbf081a248?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      ),
    ];
  }
}
