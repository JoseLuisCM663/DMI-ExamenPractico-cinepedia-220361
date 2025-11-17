import 'package:cinemapedia_220361/config/helpers/human_formats.dart';
import 'package:cinemapedia_220361/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import 'package:cinemapedia_220361/presentation/providers/movies/movie_rating_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieHorizontalListview extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  const MovieHorizontalListview({
    super.key,
    required this.movies,
    this.title,
    this.subTitle,
    this.loadNextPage,
  });

  @override
  State<MovieHorizontalListview> createState() =>
      _MovieHorizontalListviewState();
}

class _MovieHorizontalListviewState extends State<MovieHorizontalListview> {
  final scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;
      if (scrollController.position.pixels + 200 >=
          scrollController.position.maxScrollExtent) {
        print('Cargando las peliculas siguientes');
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
            _CurrDate(place: widget.title, formatedDate: widget.subTitle),

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return _Slide(movie: widget.movies[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- SLIDE ----------------

class _Slide extends ConsumerWidget {
  final Movie movie;

  const _Slide({required this.movie});

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

    // Provider real que llama a TMDB
    final ratingAsync = ref.watch(movieRatingProvider(movie.id));

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Poster
          SizedBox(
            width: 150,
            height: 215,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: GestureDetector(
                onTap: () => context.push('/movie/${movie.id}'),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/loaders/bottle-loader.gif',
                  image: movie.posterPath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          const SizedBox(height: 5),

          // Titulo
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textStyles.titleSmall,
            ),
          ),

          const SizedBox(height: 4),

          // ---------------- CLASIFICACIÓN (PÍLDORA) ----------------
          /*
                ratingAsync.when(
                data: (rating) => Container(
                  padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  decoration: BoxDecoration(
                  color: _ratingColor(rating).withOpacity(0.85),
                  borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                  rating,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  ),
                ),

                loading: () => Container(
                  width: 22,
                  height: 22,
                  padding: const EdgeInsets.all(2),
                  child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  ),
                ),

                error: (_, __) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                  "NR",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  ),
                ),
                ),

                const SizedBox(height: 4),
          */

          // Rating y Popularidad
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
                  '${movie.voteAverage}',
                  style: textStyles.bodyMedium?.copyWith(
                    color: Colors.yellow.shade800,
                  ),
                ),
                const Spacer(),
                Text(
                  HumanFormats.humanReadbleNumber(movie.popularity),
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


// ---------------- HEADER ----------------

class _CurrDate extends StatelessWidget {
  final String? place;
  final String? formatedDate;

  const _CurrDate({this.place, this.formatedDate});

  @override
  Widget build(BuildContext context) {
    final placeStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (place != null) Text(place!, style: placeStyle),
          const Spacer(),
          if (formatedDate != null)
            FilledButton.tonal(onPressed: () {}, child: Text(formatedDate!)),
        ],
      ),
    );
  }
}
