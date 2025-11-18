
/// Модель данных для медитации.
class Meditation {
  final String id; // Уникальный идентификатор
  final String title; // Название медитации
  final String description; // Краткое описание
  final String audioUrl; // Путь к основному аудиофайлу
  final String imageUrl; // URL или путь к изображению для фона

  Meditation({
    required this.id,
    required this.title,
    required this.description,
    required this.audioUrl,
    required this.imageUrl,
  });
}
