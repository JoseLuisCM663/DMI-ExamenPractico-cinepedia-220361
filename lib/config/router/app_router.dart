import 'package:go_router/go_router.dart';

// Screens principales
import 'package:cinemapedia_220361/presentation/screens/screens.dart';

// Splash
import 'package:cinemapedia_220361/presentation/screens/splash/splash_screen.dart';

/// Configuración de navegación de la aplicación.
/// Incluye SplashScreen como pantalla inicial.
final appRouter = GoRouter(
  initialLocation: '/splash',

  routes: [
    /// --- SPLASH SCREEN ---
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
        /// --- DETALLE DE PELÍCULA ---
        GoRoute(
          path: 'movie/:id',
          name: MovieScreen.name,
          builder: (context, state) {
            final movieId = state.pathParameters['id'] ?? 'no-id';
            return MovieScreen(movieId: movieId);
          },
        ),
      ],
    ),
  ],
);
