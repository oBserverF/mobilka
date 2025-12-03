/// Модель данных для фоновой музыки.
class Music {
  final String? id;
  final String title;
  final String path; // Changed from audioUrl
  final bool isPremium;

  Music({
    this.id, // Made optional
    required this.title,
    required this.path, // Changed from audioUrl
    this.isPremium = false,
  });
}
