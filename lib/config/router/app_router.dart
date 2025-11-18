import 'package:go_router/go_router.dart';
// flutter material no es necesario en este archivo

// Screens principales
import 'package:cinemapedia_220361/presentation/screens/screens.dart';

// Splash
import 'package:cinemapedia_220361/presentation/screens/splash/splash_screen.dart';

// Series
import 'package:cinemapedia_220361/presentation/screens/series/series_screen.dart';
import 'package:cinemapedia_220361/presentation/screens/series/series_detail_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    /// --- SPLASH ---
    GoRoute(
      path: '/splash',
      name: SplashScreen.name,
      builder: (context, state) => const SplashScreen(),
    ),

    /// --- HOME ---
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
      routes: [
        /// --- DETALLE MOVIE ---
        GoRoute(
          path: 'movie/:id',
          name: MovieScreen.name,
          builder: (context, state) {
            final movieId = state.pathParameters['id'] ?? 'no-id';
            return MovieScreen(movieId: movieId);
          },
        ),

        /// --- LISTADO SERIES ---
        GoRoute(
          path: 'series',
          name: SeriesScreen.name,
          builder: (context, state) => const SeriesScreen(),
        ),

        /// --- DETALLE DE UNA SERIE ---
        GoRoute(
          path: 'series/:id',
          name: SeriesDetailScreen.name,
          builder: (context, state) {
            final seriesId = state.pathParameters['id'] ?? 'no-id';
            return SeriesDetailScreen(seriesId: seriesId);
          },
        ),
      ],
    ),
  ],
);
