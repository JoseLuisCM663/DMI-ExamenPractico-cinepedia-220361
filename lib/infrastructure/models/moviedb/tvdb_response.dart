class TvDbResponse {
  final int page;
  final List<TvDb> results;
  final int totalPages;
  final int totalResults;

  TvDbResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory TvDbResponse.fromJson(Map<String, dynamic> json) => TvDbResponse(
    page: json["page"],
    results: List<TvDb>.from(json["results"].map((x) => TvDb.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );
}

class TvDb {
  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final int id;
  final String name;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final String posterPath;
  final DateTime firstAirDate;
  final List<String> originCountry;
  final double popularity;
  final double voteAverage;
  final int voteCount;
  final int numberOfSeasons;

  TvDb({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.name,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.firstAirDate,
    required this.originCountry,
    required this.popularity,
    required this.voteAverage,
    required this.voteCount,
    required this.numberOfSeasons,
  });

  factory TvDb.fromJson(Map<String, dynamic> json) => TvDb(
    adult: json["adult"] ?? false,
    backdropPath: json["backdrop_path"] ?? "no-backdrop",
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    id: json["id"],
    name: json["name"],
    originalLanguage: json["original_language"],
    originalName: json["original_name"],
    overview: json["overview"] ?? "",
    posterPath: json["poster_path"] ?? "no-poster",
    firstAirDate: json["first_air_date"] == null
        ? DateTime(1900)
        : DateTime.parse(json["first_air_date"]),
    originCountry: List<String>.from(json["origin_country"].map((x) => x)),
    popularity: (json["popularity"] ?? 0).toDouble(),
    voteAverage: (json["vote_average"] ?? 0).toDouble(),
    voteCount: json["vote_count"] ?? 0,
    numberOfSeasons: json["number_of_seasons"] ?? 0,
  );
}
