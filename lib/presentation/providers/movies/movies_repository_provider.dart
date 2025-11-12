import 'package:cinemapedia_220361/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia_220361/infrastructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider que proporciona una instancia del repositorio de películas.
///
/// Configura la inyección de dependencias conectando el repositorio
/// con su datasource correspondiente (TheMovieDB API).
///
final movieRepositoryProvider = Provider((ref) {
  /// Crea instancia del repositorio inyectando el datasource de TheMovieDB
  /// Esta configuración conecta toda la cadena: UI -> Repository -> Datasource -> API
  return MovieRepositoryImpl(MoviedbDataSource());
});
