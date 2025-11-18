import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia_220361/presentation/providers/series/series_providers.dart';
import 'package:cinemapedia_220361/presentation/widgets/shared/custom_bottom_navigationbar.dart';
import 'package:cinemapedia_220361/presentation/widgets/shared/custom_appbar.dart';
import 'package:cinemapedia_220361/presentation/widgets/shared/fullscreen_loader.dart';
import 'package:cinemapedia_220361/presentation/widgets/series/series_slideshow.dart';
import 'package:cinemapedia_220361/presentation/widgets/series/series_horizontal_listview.dart';

class SeriesScreen extends StatelessWidget {
  static const name = 'series-screen';

  const SeriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _SeriesView(),
      bottomNavigationBar: CustomBottomNavigationbar(),
    );
  }
}

class _SeriesView extends ConsumerStatefulWidget {
  const _SeriesView();

  @override
  _SeriesViewState createState() => _SeriesViewState();
}

class _SeriesViewState extends ConsumerState<_SeriesView> {
  @override
  void initState() {
    super.initState();

    /// Cargar las diferentes categorías de series
    ref.read(onAirSeriesProvider.notifier).loadNextPage();
    ref.read(popularSeriesProvider.notifier).loadNextPage();
    ref.read(topRatedSeriesProvider.notifier).loadNextPage();
    ref.read(upcomingSeriesProvider.notifier).loadNextPage();
    ref.read(mexicanSeriesProvider.notifier).loadNextPage();
  }

  String _nombreDia(int dia) {
    const dias = [
      "Lunes",
      "Martes",
      "Miércoles",
      "Jueves",
      "Viernes",
      "Sábado",
      "Domingo",
    ];
    return dias[dia - 1];
  }

  String _nombreMes(int mes) {
    const meses = [
      "Enero",
      "Febrero",
      "Marzo",
      "Abril",
      "Mayo",
      "Junio",
      "Julio",
      "Agosto",
      "Septiembre",
      "Octubre",
      "Noviembre",
      "Diciembre",
    ];
    return meses[mes - 1];
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingSeries = ref.watch(onAirSeriesProvider);
    final popularSeries = ref.watch(popularSeriesProvider);
    final topRatedSeries = ref.watch(topRatedSeriesProvider);
    final upcomingSeries = ref.watch(upcomingSeriesProvider);
    final slideShowSeries = ref.watch(seriesSlideShowProvider);
    final mexicanSeries = ref.watch(mexicanSeriesProvider);

    final now = DateTime.now();
    final fechaActual =
        "${_nombreDia(now.weekday)} ${now.day} de ${_nombreMes(now.month)}";

    return CustomScrollView(
      slivers: [
        const SliverAppBar(floating: true, title: CustomAppbar()),

        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            if (index > 0) return null;

            return Column(
              children: [
                const SizedBox(height: 10),

                /// Slideshow de series
                SeriesSlideshow(series: slideShowSeries),

                /// Series transmitiéndose actualmente
                SeriesHorizontalListview(
                  series: nowPlayingSeries,
                  title: 'En emisión',
                  subTitle: fechaActual,
                  loadNextPage: () =>
                      ref.read(onAirSeriesProvider.notifier).loadNextPage(),
                ),

                /// Próximas series o nuevas temporadas
                SeriesHorizontalListview(
                  series: upcomingSeries,
                  title: 'Próximamente',
                  subTitle: now.year.toString(),
                  isUpcoming: true,
                  loadNextPage: () =>
                      ref.read(upcomingSeriesProvider.notifier).loadNextPage(),
                ),

                /// Series populares
                SeriesHorizontalListview(
                  series: popularSeries,
                  title: 'Populares',
                  loadNextPage: () =>
                      ref.read(popularSeriesProvider.notifier).loadNextPage(),
                ),

                /// Series mexicanas
                SeriesHorizontalListview(
                  series: mexicanSeries,
                  title: 'Series mexicanas',
                  loadNextPage: () =>
                      ref.read(mexicanSeriesProvider.notifier).loadNextPage(),
                ),

                /// Series mejor calificadas
                SeriesHorizontalListview(
                  series: topRatedSeries,
                  title: 'Mejor valoradas',
                  subTitle: now.year.toString(),
                  loadNextPage: () =>
                      ref.read(topRatedSeriesProvider.notifier).loadNextPage(),
                ),

                const SizedBox(height: 20),
              ],
            );
          }, childCount: 1),
        ),
      ],
    );
  }
}
