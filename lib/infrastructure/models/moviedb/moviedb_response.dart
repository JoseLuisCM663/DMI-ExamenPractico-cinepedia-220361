import 'movie_moviedb.dart';

/// Modelo que representa la respuesta completa de la API de TheMovieDB.
///
/// Mapea la estructura JSON completa que devuelve la API, incluyendo
/// metadatos de paginación y la lista de películas.
///

class MovieDbResponse {
  MovieDbResponse({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final Dates? dates;
  final int page;
  final List<MovieMovieDB> results;
  final int totalPages;
  final int totalResults;

  /// Crea instancia desde JSON de la API
  factory MovieDbResponse.fromJson(Map<String, dynamic> json) =>
      MovieDbResponse(
        dates: json["dates"] != null ? Dates.fromJson(json["dates"]) : null,
        page: json["page"],
        results: List<MovieMovieDB>.from(
          json["results"].map((x) => MovieMovieDB.fromJson(x)),
        ),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  /// Convierte instancia a JSON
  Map<String, dynamic> toJson() => {
    "dates": dates == null ? null : dates!.toJson(),
    "page": page,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

/// Modelo que representa el rango de fechas para películas en cartelera.
///
/// Indica el período de tiempo en el que las películas están disponibles
/// en cines (fecha mínima y máxima).
class Dates {
  Dates({required this.maximum, required this.minimum});

  final DateTime maximum;
  final DateTime minimum;

  /// Crea instancia desde JSON de la API
  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
    maximum: DateTime.parse(json["maximum"]),
    minimum: DateTime.parse(json["minimum"]),
  );

  /// Convierte instancia a JSON
  Map<String, dynamic> toJson() => {
    "maximum":
        "${maximum.year.toString().padLeft(4, '0')}-${maximum.month.toString().padLeft(2, '0')}-${maximum.day.toString().padLeft(2, '0')}",
    "minimum":
        "${minimum.year.toString().padLeft(4, '0')}-${minimum.month.toString().padLeft(2, '0')}-${minimum.day.toString().padLeft(2, '0')}",
  };
}
