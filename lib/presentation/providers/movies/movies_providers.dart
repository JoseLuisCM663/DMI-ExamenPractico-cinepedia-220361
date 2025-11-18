import 'package:cinemapedia_220361/domain/entities/movie.dart';
import 'package:cinemapedia_220361/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🔹 1. Definimos el tipo de función callback
typedef MovieCallback = Future<List<Movie>> Function({int page});

// 🔹 2. Provider para NowPlaying
final nowPlayingMoviesProvider = NotifierProvider<MoviesNotifier, List<Movie>>(
  () =>
      MoviesNotifier((ref) => ref.watch(movieRepositoryProvider).getNowPlaying),
);

// 🔹 2. Provider para Popular Movie
final popularMoviesProvider = NotifierProvider<MoviesNotifier, List<Movie>>(
  () => MoviesNotifier((ref) => ref.watch(movieRepositoryProvider).getPopular),
);

// 🔹 2. Provider para UpComing
final upcomingMoviesProvider = NotifierProvider<MoviesNotifier, List<Movie>>(
  () {
    return MoviesNotifier((ref) {
      return ({int page = 1}) async {
        final movies = await ref
            .watch(movieRepositoryProvider)
            .getUpcoming(page: page);

        final now = DateTime.now();

        // 🔥 Regresar solo películas del MISMO mes y año actuales
        return movies.where((m) {
          final d = m.releaseDate; // <-- YA ES DateTime
          return d.year == now.year && d.month == now.month;
        }).toList();
      };
    });
  },
);

// 🔹 2. Provider para TopRated
final topratedMoviesProvider = NotifierProvider<MoviesNotifier, List<Movie>>(
  () => MoviesNotifier((ref) => ref.watch(movieRepositoryProvider).getTopRated),
);

// 🔹 2. Provider para MexicanMovies
final mexicanMoviesProvider = NotifierProvider<MoviesNotifier, List<Movie>>(
  () => MoviesNotifier(
    (ref) => ref.watch(movieRepositoryProvider).getMexicanMovies,
  ),
);

// 🔹 3. El Notifier que maneja el estado
class MoviesNotifier extends Notifier<List<Movie>> {
  final MovieCallback Function(Ref ref) _callbackBuilder;
  late final MovieCallback fetchMoreMovies;

  MoviesNotifier(this._callbackBuilder);

  int currentPage = 0;
  bool isLoading = false;

  @override
  List<Movie> build() {
    //final repository = ref.watch(movieRepositoryProvider); // Obtenemos el repositorio desde el ref
    fetchMoreMovies = _callbackBuilder(ref);
    return [];
  }

  Future<void> loadNextPage() async {
    if (isLoading) return;
    isLoading = true;

    currentPage++;
    final movies = await fetchMoreMovies(page: currentPage);

    state = [...state, ...movies];

    isLoading = false;
  }
}
