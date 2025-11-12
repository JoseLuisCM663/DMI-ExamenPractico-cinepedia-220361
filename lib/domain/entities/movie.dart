/// Entidad que representa una película en el dominio de la aplicación.
///
/// Esta clase define la estructura de datos de una película que usa
/// la lógica de negocio, independiente de cómo se almacene o se obtenga.
///
/// **Propósito:**
/// - Modelo de datos puro sin dependencias externas
/// - Representa el concepto de "película" en el negocio
/// - Usado por toda la aplicación de forma consistente
///
class Movie {
  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;
  Movie({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });
}
