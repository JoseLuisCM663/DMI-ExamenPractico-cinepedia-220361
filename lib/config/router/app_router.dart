import 'package:cinemapedia_220361/presentation/screens/screens.dart';
import 'package:cinemapedia_220361/presentation/screens/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

/// Configuración principal de navegación de la aplicación.
/// Incluye la pantalla de Splash como pantalla inicial.
final appRouter = GoRouter(
  // La primera pantalla deberá ser el Splash
  initialLocation: '/splash',

  routes: [
    /// --- RUTA DEL SPLASH ---
    GoRoute(
      path: '/splash',
      name: 'splash-screen',
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
