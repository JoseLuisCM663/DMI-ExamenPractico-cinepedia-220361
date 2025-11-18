import 'package:cinemapedia_220361/domain/entities/series.dart';
import 'package:cinemapedia_220361/infrastructure/models/moviedb/tvdb_response.dart';

class SeriesMapper {
  static Series tvDBToEntity(TvDb serie) => Series(
    id: serie.id,
    name: serie.name,
    originalName: serie.originalName,
    overview: serie.overview,
    posterPath: serie.posterPath != 'no-poster'
        ? 'https://image.tmdb.org/t/p/w500${serie.posterPath}'
        : 'https://via.placeholder.com/300x450?text=No+Image',
    backdropPath: serie.backdropPath != 'no-backdrop'
        ? 'https://image.tmdb.org/t/p/w500${serie.backdropPath}'
        : 'https://via.placeholder.com/300x200?text=No+Image',
    firstAirDate: serie.firstAirDate,
    originCountry: serie.originCountry,
    popularity: serie.popularity,
    voteAverage: serie.voteAverage,
    voteCount: serie.voteCount,
    genreIds: serie.genreIds,
    originalLanguage: serie.originalLanguage,
    numberOfSeasons: serie.numberOfSeasons,
  );
}
