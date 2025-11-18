import 'package:cinemapedia_220361/domain/entities/series.dart';

/// Contrato abstracto para obtener datos de series.
/// Funciona igual que MoviesDatasource pero aplicado a series.
abstract class SeriesDatasource {
  Future<List<Series>> getOnTheAir({int page = 1}); // Series actuales
  Future<List<Series>> getUpcoming({int page = 1}); // Próximas series
  Future<List<Series>> getPopular({int page = 1}); // Populares
  Future<List<Series>> getTopRated({int page = 1}); // Mejor valoradas
  Future<List<Series>> getAiringToday({int page = 1}); // Por estrenar
  Future<List<Series>> getMexicanSeries({int page = 1}); // Series mexicanas
  Future<Series> getSeriesById(String id);
}
