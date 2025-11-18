import 'package:cinemapedia_220361/domain/entities/series.dart';
import 'package:cinemapedia_220361/presentation/providers/series/series_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef SeriesCallback = Future<List<Series>> Function({int page});

final onAirSeriesProvider = NotifierProvider<SeriesNotifier, List<Series>>(
  () =>
      SeriesNotifier((ref) => ref.watch(seriesRepositoryProvider).getOnTheAir),
);

final upcomingSeriesProvider = NotifierProvider<SeriesNotifier, List<Series>>(
  () => SeriesNotifier(
    (ref) => ref.watch(seriesRepositoryProvider).getUpcoming,
  ),
);


final popularSeriesProvider = NotifierProvider<SeriesNotifier, List<Series>>(
  () => SeriesNotifier((ref) => ref.watch(seriesRepositoryProvider).getPopular),
);
final topRatedSeriesProvider = NotifierProvider<SeriesNotifier, List<Series>>(
  () =>
      SeriesNotifier((ref) => ref.watch(seriesRepositoryProvider).getTopRated),
);
final mexicanSeriesProvider = NotifierProvider<SeriesNotifier, List<Series>>(
  () => SeriesNotifier(
    (ref) => ref.watch(seriesRepositoryProvider).getMexicanSeries,
  ),
);
final seriesSlideShowProvider = Provider<List<Series>>((ref) {
  final series = ref.watch(popularSeriesProvider);

  return series.take(10).toList();
});


class SeriesNotifier extends Notifier<List<Series>> {
  final SeriesCallback Function(Ref ref) _callbackBuilder;
  late final SeriesCallback fetchMoreSeries;

  SeriesNotifier(this._callbackBuilder);

  int currentPage = 0;
  bool isLoading = false;

  @override
  List<Series> build() {
    fetchMoreSeries = _callbackBuilder(ref);
    return [];
  }

  Future<void> loadNextPage() async {
    if (isLoading) return;

    isLoading = true;
    currentPage++;

    final series = await fetchMoreSeries(page: currentPage);

    state = [...state, ...series];

    isLoading = false;
  }
}
