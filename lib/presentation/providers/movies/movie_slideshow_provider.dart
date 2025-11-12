import 'package:cinemapedia_220361/domain/entities/movie.dart';
import 'package:cinemapedia_220361/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieSlideShowProvider = Provider<List<Movie>>((ref) {
  {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    if (nowPlayingMovies.isEmpty) return [];
    return nowPlayingMovies.sublist(0, 6);
  }
});
