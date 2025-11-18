import 'package:cinemapedia_220361/domain/entities/series.dart';

/// Repositorio abstracto para series.
/// Encapsula la lógica de negocio de alto nivel.
abstract class SeriesRepository {
  Future<List<Series>> getOnTheAir({int page = 1});
  Future<List<Series>> getUpcoming({int page = 1});
  Future<List<Series>> getPopular({int page = 1});
  Future<List<Series>> getTopRated({int page = 1});
  Future<List<Series>> getAiringToday({int page = 1});
  Future<List<Series>> getMexicanSeries({int page = 1});
  Future<Series> getSeriesById(String id);
}
