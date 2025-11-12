/// Modelo de datos que representa una película según la estructura de TheMovieDB API.
///
/// Esta clase mapea directamente la respuesta JSON de la API externa,
/// manteniendo la estructura y nombres de campos originales.
///
/// **Propósito:**
/// - Deserializar respuestas JSON de la API
/// - Mantener compatibilidad con el formato externo
/// - Servir como modelo intermedio antes de convertir a entidades de dominio
///
class MovieMovieDB {
  MovieMovieDB({
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

  /// Campos que mapean directamente con la respuesta de la API
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

  /// Crea una instancia desde un mapa JSON de la API
  /// Incluye validaciones y valores por defecto para campos opcionales
  factory MovieMovieDB.fromJson(Map<String, dynamic> json) => MovieMovieDB(
    adult: json["adult"] ?? false,
    backdropPath: json["backdrop_path"] ?? '',
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    id: json["id"],
    originalLanguage: json["original_language"],
    originalTitle: json["original_title"],
    overview: json["overview"] ?? '',
    popularity: json["popularity"]?.toDouble(),
    posterPath: json["poster_path"] ?? '',
    // releaseDate: DateTime.parse(json["release_date"]),
    releaseDate:
        (json["release_date"] != null &&
            json["release_date"].toString().isNotEmpty)
        ? DateTime.tryParse(json["release_date"]) ?? DateTime(1900)
        : DateTime(1900),

    title: json["title"],
    video: json["video"],
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
  );

  /// Convierte la instancia a un mapa JSON
  /// Útil para serialización o envío de datos
  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "id": id,
    "original_language": originalLanguage,
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "release_date":
        "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
    "title": title,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}
