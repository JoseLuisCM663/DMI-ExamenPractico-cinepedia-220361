import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia_220361/presentation/providers/movies/movies_repository_provider.dart';

final movieRatingProvider =
    FutureProvider.family<String, int>((ref, movieId) async {
  final repository = ref.watch(movieRepositoryProvider);
  return await repository.getMovieCertification(movieId);
});
