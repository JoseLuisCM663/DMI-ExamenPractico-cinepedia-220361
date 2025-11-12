import 'package:cinemapedia_220361/domain/entities/movie.dart';
import 'package:cinemapedia_220361/infrastructure/models/moviedb/movie_moviedb.dart';

/// Mapper que convierte modelos de datos externos a entidades de dominio.
///
/// Se encarga de transformar objetos MovieMovieDB (de la API) a objetos Movie
/// (entidad de dominio), aplicando transformaciones necesarias como URLs completas.
///
class MovieMapper {
  /// Convierte un objeto MovieMovieDB a una entidad Movie del dominio.
  ///
  /// **Transformaciones aplicadas:**
  /// - Construye URLs completas para imágenes (backdrop y poster)
  /// - Proporciona imágenes por defecto si no existen
  /// - Mantiene todos los demás campos sin modificación
  ///
  /// **Parámetros:**
  /// - `moviedb`: Modelo de datos de la API de TheMovieDB
  ///
  /// **Retorna:** Entidad Movie lista para usar en el dominio
  static Movie movieDBToEntity(MovieMovieDB moviedb) => Movie(
    adult: moviedb.adult,
    backdropPath: (moviedb.backdropPath != '')
        ? 'http://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
        : 'https://sd.keepcalms.com/i-w600/keep-calm-poster-not-found.jpg',
    genreIds: moviedb.genreIds,
    id: moviedb.id,
    originalLanguage: moviedb.originalLanguage,
    originalTitle: moviedb.originalTitle,
    overview: moviedb.overview,
    popularity: moviedb.popularity,
    posterPath: (moviedb.posterPath != '')
        ? 'http://image.tmdb.org/t/p/w500${moviedb.posterPath}'
        : 'no-poster',
    releaseDate: moviedb.releaseDate,
    title: moviedb.title,
    video: moviedb.video,
    voteAverage: moviedb.voteAverage,
    voteCount: moviedb.voteCount,
  );
}
