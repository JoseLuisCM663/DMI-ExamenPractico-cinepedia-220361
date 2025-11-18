import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:go_router/go_router.dart';

import 'package:cinemapedia_220361/domain/entities/series.dart';

class SeriesSlideshow extends StatelessWidget {
  final List<Series> series;

  const SeriesSlideshow({super.key, required this.series});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      width: double.infinity,
      child: Swiper(
        viewportFraction: 0.85,
        scale: 0.9,
        autoplay: true,
        autoplayDelay: 4000,
        itemCount: series.length,
        itemBuilder: (context, index) =>
            _SlideShowItem(series: series[index]),
      ),
    );
  }
}

class _SlideShowItem extends StatelessWidget {
  final Series series;

  const _SlideShowItem({required this.series});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => context.push('/series/${series.id}'),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Imagen principal
              SizedBox.expand(
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/loaders/bottle-loader.gif',
                  image: series.backdropPath,
                  fit: BoxFit.cover,
                ),
              ),

              // Degradado superior e inferior
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black87,
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black87,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 0.25, 0.65, 1.0],
                  ),
                ),
              ),

              // CONTENIDO
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: FadeInUp(
                  duration: const Duration(milliseconds: 500),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ----- TÍTULO -----
                      Text(
                        series.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textStyles.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: const [
                            Shadow(
                              blurRadius: 8,
                              color: Colors.black,
                              offset: Offset(2, 2),
                            )
                          ],
                        ),
                      ),

                      const SizedBox(height: 6),

                      // ----- FECHA DE PRIMER EPISODIO -----
                      Text(
                        "Primer episodio: "
                        "${series.firstAirDate.year}-"
                        "${series.firstAirDate.month.toString().padLeft(2, '0')}-"
                        "${series.firstAirDate.day.toString().padLeft(2, '0')}",
                        style: textStyles.bodyMedium?.copyWith(
                          color: Colors.white70,
                        ),
                      ),

                      const SizedBox(height: 6),

                      // ----- POPULARIDAD -----
                      Text(
                        "Popularidad: ${series.popularity.toStringAsFixed(1)}",
                        style: textStyles.bodyMedium?.copyWith(
                          color: Colors.white70,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
