import 'package:dio/dio.dart';
import 'package:cinemapedia_220361/domain/datasources/series_datasource.dart';
import 'package:cinemapedia_220361/config/constants/environment.dart';
import 'package:cinemapedia_220361/infrastructure/models/moviedb/tvdb_response.dart';
import 'package:cinemapedia_220361/infrastructure/mappers/series_mapper.dart';
import 'package:cinemapedia_220361/domain/entities/series.dart';

class SeriesDbDatasource implements SeriesDatasource {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'es-MX',
      },
    ),
  );

  /// -------------------------------
  /// 🔹 Series Actuales (on the air)
  /// -------------------------------
  @override
  Future<List<Series>> getOnTheAir({int page = 1}) async {
    final response = await dio.get(
      '/tv/on_the_air',
      queryParameters: {'page': page},
    );

    final tvResponse = TvDbResponse.fromJson(response.data);

    return tvResponse.results
        .map((tv) => SeriesMapper.tvDBToEntity(tv))
        .toList();
  }

  /// -------------------------------
  /// 🔹 Próximas series (upcoming)
  /// -------------------------------
  @override
  Future<List<Series>> getUpcoming({int page = 1}) async {
    // `upcoming` para TV no tiene un endpoint explícito como en movies.
    // Usamos `airing_today` para representar próximas emisiones/futuros estrenos.
    final response = await dio.get(
      '/tv/airing_today',
      queryParameters: {'page': page},
    );

    final tvResponse = TvDbResponse.fromJson(response.data);

    return tvResponse.results
        .map((tv) => SeriesMapper.tvDBToEntity(tv))
        .toList();
  }

  /// -------------------------------
  /// 🔹 Series Populares
  /// -------------------------------
  @override
  Future<List<Series>> getPopular({int page = 1}) async {
    final response = await dio.get(
      '/tv/popular',
      queryParameters: {'page': page},
    );

    final tvResponse = TvDbResponse.fromJson(response.data);

    return tvResponse.results
        .map((tv) => SeriesMapper.tvDBToEntity(tv))
        .toList();
  }

  /// -------------------------------
  /// 🔹 Series Mejor valoradas
  /// -------------------------------
  @override
  Future<List<Series>> getTopRated({int page = 1}) async {
    final response = await dio.get(
      '/tv/top_rated',
      queryParameters: {'page': page},
    );

    final tvResponse = TvDbResponse.fromJson(response.data);

    return tvResponse.results
        .map((tv) => SeriesMapper.tvDBToEntity(tv))
        .toList();
  }

  /// -------------------------------
  /// 🔹 Series por estrenar (airing today)
  /// -------------------------------
  @override
  Future<List<Series>> getAiringToday({int page = 1}) async {
    final response = await dio.get(
      '/tv/airing_today',
      queryParameters: {'page': page},
    );

    final tvResponse = TvDbResponse.fromJson(response.data);

    return tvResponse.results
        .map((tv) => SeriesMapper.tvDBToEntity(tv))
        .toList();
  }

  /// -------------------------------
  /// 🔹 Series Mexicanas
  /// -------------------------------
  @override
  Future<List<Series>> getMexicanSeries({int page = 1}) async {
    final response = await dio.get(
      '/discover/tv',
      queryParameters: {
        'page': page,
        'with_origin_country': 'MX',
        'sort_by': 'first_air_date.desc',
        'vote_count.gte': 5,
      },
    );

    final tvResponse = TvDbResponse.fromJson(response.data);

    return tvResponse.results
        .map((tv) => SeriesMapper.tvDBToEntity(tv))
        .toList();
  }

  /// -------------------------------
  /// 🔹 Detalle de una serie por ID
  /// -------------------------------
  @override
  Future<Series> getSeriesById(String id) async {
    final response = await dio.get('/tv/$id');

    final tv = TvDb.fromJson(response.data);

    return SeriesMapper.tvDBToEntity(tv);
  }
}
