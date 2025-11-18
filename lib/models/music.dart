/// Модель данных для фоновой музыки.
class Music {
  final String id;
  final String title;
  final String audioUrl;
  final bool isPremium;

  Music({
    required this.id,
    required this.title,
    required this.audioUrl,
    this.isPremium = false, // По умолчанию музыка доступна
  });
}
