import 'package:cinemapedia_220361/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia_220361/domain/entities/movie.dart';
import 'package:cinemapedia_220361/domain/repositories/movies_repository.dart';

/// Implementación concreta del repositorio de películas.
///
/// Actúa como intermediario entre la capa de presentación y el datasource,
/// aplicando lógica de negocio si es necesaria antes de devolver los datos.
class MovieRepositoryImpl implements MoviesRepository {
  /// Datasource que se encarga del acceso real a los datos
  final MoviesDatasource datasource;

  /// Constructor que recibe el datasource por inyección de dependencias
  MovieRepositoryImpl(this.datasource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return datasource.getPopular(page: page);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return datasource.getUpcoming(page: page);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return datasource.getTopRated(page: page);
  }

  @override
  Future<List<Movie>> getMexicanMovies({int page = 1}) {
    return datasource.getMexicanMovies(page: page);
  }
  @override
  Future<String> getMovieCertification(int movieId) {
  return datasource.getMovieCertification(movieId);
}

}
