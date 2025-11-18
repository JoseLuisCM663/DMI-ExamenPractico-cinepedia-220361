import 'package:cinemapedia_220361/infrastructure/datasources/seriesdb_datasource.dart';
import 'package:cinemapedia_220361/infrastructure/repositories/series_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider que proporciona una instancia del repositorio de series.
///
/// Configura la inyección de dependencias conectando el repositorio
/// con su datasource correspondiente (TheMovieDB API para series).
///
/// Esta configuración conecta toda la cadena:
/// UI -> Repository -> Datasource -> API
final seriesRepositoryProvider = Provider((ref) {
  return SeriesRepositoryImpl(SeriesDbDatasource());
});
