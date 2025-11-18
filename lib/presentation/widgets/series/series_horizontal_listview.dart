import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:cinemapedia_220361/config/helpers/human_formats.dart';
import 'package:cinemapedia_220361/domain/entities/series.dart';

/// ---------------------------------------------------------------------------
///                          LISTA HORIZONTAL DE SERIES
/// ---------------------------------------------------------------------------
/// Este widget se usa para TODAS las categorías del punto 11:
/// - Series Actuales (En emisión)
/// - Series Por Estrenarse (incluye temporada)
/// - Series Populares
/// - Series Mejor Valoradas
/// - Series Mexicanas
/// ---------------------------------------------------------------------------

class SeriesHorizontalListview extends StatefulWidget {
  final List<Series> series;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  /// Si TRUE → es categoría "POR ESTRENARSE"
  /// Se mostrará fecha y temporada.
  final bool isUpcoming;

  const SeriesHorizontalListview({
    super.key,
    required this.series,
    this.title,
    this.subTitle,
    this.loadNextPage,
    this.isUpcoming = false,
  });

  @override
  State<SeriesHorizontalListview> createState() =>
      _SeriesHorizontalListviewState();
}

class _SeriesHorizontalListviewState extends State<SeriesHorizontalListview> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;

      if (scrollController.position.pixels + 200 >=
          scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,
      child: Column(
        children: [
          if (widget.title != null || widget.subTitle != null)
            _HeaderSection(title: widget.title, subTitle: widget.subTitle),

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.series.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return _SeriesSlide(
                  series: widget.series[index],
                  isUpcoming: widget.isUpcoming,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
///                              TARJETA DE SERIE
/// ---------------------------------------------------------------------------

class _SeriesSlide extends ConsumerWidget {
  final Series series;
  final bool isUpcoming;

  const _SeriesSlide({required this.series, required this.isUpcoming});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyles = Theme.of(context).textTheme;

    final formattedShortDate = DateFormat(
      'dd/MM/yyyy',
    ).format(series.firstAirDate);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ---------------- POSTER ----------------
          SizedBox(
            width: 150,
            height: 215,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: GestureDetector(
                onTap: () => context.push('/series/${series.id}'),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/loaders/bottle-loader.gif',
                  image: series.posterPath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          const SizedBox(height: 6),

          // ---------------- TÍTULO ----------------
          SizedBox(
            width: 150,
            child: Text(
              series.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textStyles.titleSmall,
            ),
          ),

          // ---------------- SOLO UPCOMING ----------------
          if (isUpcoming) ...[
            SizedBox(
              width: 150,
              child: Text(
                "Estreno: $formattedShortDate",
                style: textStyles.bodySmall!.copyWith(color: Colors.grey),
              ),
            ),

            // TEMPORADA visible SOLO en “Próximamente”
            SizedBox(
              width: 150,
              child: Text(
                // Mostrar al menos 1 si el valor es 0 (desconocido)
                "Temporada: ${series.numberOfSeasons > 0 ? series.numberOfSeasons : 1}",
                style: textStyles.bodySmall!.copyWith(color: Colors.blueGrey),
              ),
            ),
          ],

          // ---------------- RATING & POPULARIDAD ----------------
          if (!isUpcoming)
            SizedBox(
              width: 150,
              child: Row(
                children: [
                  Icon(
                    Icons.star_half_outlined,
                    color: Colors.yellow.shade800,
                    size: 16,
                  ),
                  const SizedBox(width: 3),
                  Text(
                    '${series.voteAverage}',
                    style: textStyles.bodyMedium?.copyWith(
                      color: Colors.yellow.shade800,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    HumanFormats.humanReadbleNumber(series.popularity),
                    style: textStyles.bodySmall,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
///                               HEADER
/// ---------------------------------------------------------------------------

class _HeaderSection extends StatelessWidget {
  final String? title;
  final String? subTitle;

  const _HeaderSection({this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (title != null) Text(title!, style: titleStyle),
          const Spacer(),
          if (subTitle != null)
            FilledButton.tonal(onPressed: () {}, child: Text(subTitle!)),
        ],
      ),
    );
  }
}
