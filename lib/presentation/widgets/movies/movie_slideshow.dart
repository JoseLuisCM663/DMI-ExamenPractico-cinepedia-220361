import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia_220361/domain/entities/movie.dart';
import 'package:cinemapedia_220361/presentation/providers/movies/movie_rating_provider.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieSlideshow extends StatelessWidget {
  final List<Movie> movies;

  const MovieSlideshow({super.key, required this.movies});

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
        itemCount: movies.length,
        itemBuilder: (context, index) => _SlideShowItem(movie: movies[index]),
      ),
    );
  }
}

class _SlideShowItem extends ConsumerWidget {
  final Movie movie;

  const _SlideShowItem({required this.movie});

  Color _ratingColor(String rating) {
    switch (rating) {
      case "G":
        return Colors.greenAccent;
      case "PG":
        return Colors.lightBlueAccent;
      case "PG-13":
        return Colors.orangeAccent;
      case "R":
        return Colors.redAccent;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyles = Theme.of(context).textTheme;

    // Petición real
    final ratingAsync = ref.watch(movieRatingProvider(movie.id));

    return GestureDetector(
      onTap: () => context.push('/movie/${movie.id}'),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Imagen principal
              SizedBox.expand(
                child: Image.network(
                  movie.backdropPath,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(
                      child: SizedBox(
                        height: 36,
                        width: 36,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
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

              // CONTENIDO (Texto + Píldora)
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: FadeInUp(
                  duration: const Duration(milliseconds: 500),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ----- CLASIFICACIÓN REAL -----
                      ratingAsync.when(
                        data: (rating) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _ratingColor(rating).withOpacity(0.85),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            rating,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        loading: () => Container(
                          padding: const EdgeInsets.all(4),
                          child: const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        error: (_, __) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.85),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Text(
                            "NR",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      // ----- TÍTULO -----
                      Text(
                        movie.title,
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
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 5),

                      // ----- FECHA DE ESTRENO -----
                      Text(
                        "Estreno: ${movie.releaseDate.year}-${movie.releaseDate.month.toString().padLeft(2, '0')}-${movie.releaseDate.day.toString().padLeft(2, '0')}",
                        style: textStyles.bodyMedium?.copyWith(
                          color: Colors.white70,
                        ),
                      ),
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
