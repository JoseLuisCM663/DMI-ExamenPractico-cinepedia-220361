import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia_220361/domain/entities/series.dart';
import 'package:cinemapedia_220361/presentation/providers/series/series_repository_provider.dart';

/// Provider simple que obtiene el detalle de una serie por su ID.
///
/// Nota: en esta versión usamos un `FutureProvider.family` en lugar de mantener
/// un caché en memoria. Si necesitas la cache tipo mapa, lo podemos reimplementar.
final seriesInfoProvider = FutureProvider.family<Series, String>((
  ref,
  seriesId,
) async {
  final seriesRepository = ref.watch(seriesRepositoryProvider);
  return seriesRepository.getSeriesById(seriesId);
});

// NOTE: en lugar de mantener un mapa cacheado con StateNotifier,
// usamos un simple FutureProvider.family para obtener el detalle.
