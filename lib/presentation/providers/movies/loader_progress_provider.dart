import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'movies_providers.dart';

final loaderProgressProvider = Provider<double>((ref) {
  final nowPlaying = ref.watch(nowPlayingMoviesProvider).isEmpty ? 0 : 1;
  final upcoming = ref.watch(upcomingMoviesProvider).isEmpty ? 0 : 1;
  final popular = ref.watch(popularMoviesProvider).isEmpty ? 0 : 1;
  final topRated = ref.watch(topratedMoviesProvider).isEmpty ? 0 : 1;
  final mexican = ref.watch(mexicanMoviesProvider).isEmpty ? 0 : 1;

  final totalSteps = 5;
  final completed =
      nowPlaying + upcoming + popular + topRated + mexican;

  return completed / totalSteps;
});
