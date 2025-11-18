import 'package:cinemapedia_220361/config/constants/environment.dart';
import 'package:cinemapedia_220361/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia_220361/domain/entities/movie.dart';
import 'package:cinemapedia_220361/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia_220361/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

/// Implementación concreta del datasource que obtiene datos de TheMovieDB API.
///
/// Esta clase se encarga de realizar peticiones HTTP a la API de TheMovieDB
/// y convertir las respuestas JSON en entidades de dominio utilizables.
///

class MoviedbDataSource extends MoviesDatasource {
  /// Cliente HTTP configurado para la API de TheMovieDB
  /// Incluye URL base, API key y configuración de idioma
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'es-MX',
      },
    ),
  );

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    /// Realiza petición GET al endpoint de películas en cartelera
    final response = await dio.get(
      '/movie/now_playing',
      queryParameters: {'page': page},
    );

    final movieDBResponse = MovieDbResponse.fromJson(response.data);

    /// Filtra películas sin póster y las convierte a entidades
    final List<Movie> movies = movieDBResponse.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    /// Realiza petición GET al endpoint de películas en cartelera
    final response = await dio.get(
      '/movie/popular',
      queryParameters: {'page': page},
    );

    final movieDBResponse = MovieDbResponse.fromJson(response.data);

    /// Filtra películas sin póster y las convierte a entidades
    final List<Movie> movies = movieDBResponse.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    /// Realiza petición GET al endpoint de películas en cartelera
    final response = await dio.get(
      '/movie/upcoming',
      queryParameters: {'page': page},
    );

    final movieDBResponse = MovieDbResponse.fromJson(response.data);

    /// Filtra películas sin póster y las convierte a entidades
    final List<Movie> movies = movieDBResponse.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    /// Realiza petición GET al endpoint de películas en cartelera
    final response = await dio.get(
      '/movie/top_rated',
      queryParameters: {'page': page},
    );

    final movieDBResponse = MovieDbResponse.fromJson(response.data);

    /// Filtra películas sin póster y las convierte a entidades
    final List<Movie> movies = movieDBResponse.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getMexicanMovies({int page = 1}) async {
    /// Realiza petición GET al endpoint de películas en cartelera
    final response = await dio.get(
      '/discover/movie',
      queryParameters: {
        'page': page,
        'region': 'MX',
        'withOriginalLanguaje': 'es',
        'with_origin_country': 'MX',
        'sort_by': 'vote_average.desc',
        'vote_count.gte': 10,
      },
    );

    final movieDBResponse = MovieDbResponse.fromJson(response.data);

    /// Filtra películas sin póster y las convierte a entidades
    final List<Movie> movies = movieDBResponse.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();

    return movies;
  }

  @override
  Future<String> getMovieCertification(int movieId) async {
    final response = await dio.get('/movie/$movieId/release_dates');

    final results = response.data['results'] as List<dynamic>;

    // Buscamos solo clasificación de USA
    final usEntry = results.firstWhere(
      (item) => item['iso_3166_1'] == 'US',
      orElse: () => null,
    );

    if (usEntry == null) return 'NR'; // No Rated

    final releaseDates = usEntry['release_dates'] as List;

    if (releaseDates.isEmpty) return 'NR';

    final cert = releaseDates[0]['certification'];

    return cert.isEmpty ? 'NR' : cert;
  }
}
