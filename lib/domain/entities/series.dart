/// Entidad que representa una serie de televisión en el dominio de la aplicación.
///
/// Esta clase define la estructura de datos de una serie que usa
/// la lógica de negocio, independiente de cómo se almacene o se obtenga.
///
/// Campos pensados para mapear con la API de TMDB (tv endpoints).
class Series {
  final int id;
  final String name; // título de la serie
  final String originalName;
  final String overview;
  final String backdropPath;
  final String posterPath;
  final List<int> genreIds;
  final DateTime firstAirDate;
  final double popularity;
  final double voteAverage;
  final int voteCount;
  final List<String> originCountry;
  final String originalLanguage;
  final int numberOfSeasons; // opcionalmente usado si se quiere mostrar temporada

  Series({
    required this.id,
    required this.name,
    required this.originalName,
    required this.overview,
    required this.backdropPath,
    required this.posterPath,
    required this.genreIds,
    required this.firstAirDate,
    required this.popularity,
    required this.voteAverage,
    required this.voteCount,
    required this.originCountry,
    required this.originalLanguage,
    required this.numberOfSeasons,
  });
}
