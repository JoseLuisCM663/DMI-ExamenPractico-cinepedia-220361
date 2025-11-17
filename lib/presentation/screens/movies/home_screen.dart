import 'package:cinemapedia_220361/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia_220361/presentation/widgets/widgets.dart';

/// Pantalla principal de la aplicación que muestra las películas en cartelera.
///
/// **Funcionalidades:**
/// - Lista de películas actualmente en cines
/// - Carga automática de datos al iniciar
/// - Interfaz simple con título y descripción
class HomeScreen extends StatelessWidget {
  /// Identificador único para navegación con GoRouter
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigationbar(),
    );
  }
}

/// Vista interna que maneja el estado y la lógica de la pantalla principal.
///
/// **Responsabilidades:**
/// - Cargar películas al inicializar la pantalla
/// - Escuchar cambios en el provider de películas
class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

/// Estado que gestiona el ciclo de vida y la construcción de la vista.
class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    
    /// Carga la primera página de películas al inicializar la pantalla
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topratedMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(mexicanMoviesProvider.notifier).loadNextPage();
  }
  String _nombreDia(int dia) {
  const dias = [
    "Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Domingo"
  ];
  return dias[dia - 1];
}

String _nombreMes(int mes) {
  const meses = [
    "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio",
    "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"
  ];
  return meses[mes - 1];
}

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(intialLoadingProvider);

    if (initialLoading) return const FullscreenLoader();

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popular = ref.watch(popularMoviesProvider);
    final topRated = ref.watch(topratedMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final mexicanMovies = ref.watch(mexicanMoviesProvider);
    final slideShowMovies = ref.watch(movieSlideShowProvider);
    // Obtener la fecha actual del dispositivo
    final now = DateTime.now();

    // Formatear la fecha a "Lunes 27 de Octubre"
    final fechaActual = 
        "${_nombreDia(now.weekday)} ${now.day} de ${_nombreMes(now.month)}";

    /// Lista deslizable que muestra todas las películas
    return CustomScrollView(
      slivers: [
        const SliverAppBar(floating: true, title: CustomAppbar()),

        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            if (index > 0) return null; // evita infinitas repeticiones
            return Column(
              children: [
                const SizedBox(height: 10),

                MovieSlideshow(movies: slideShowMovies),

                MovieHorizontalListview(
                  movies: nowPlayingMovies,
                  title: 'En cines',
                  subTitle: fechaActual,
                  loadNextPage: () => ref
                      .read(nowPlayingMoviesProvider.notifier)
                      .loadNextPage(),
                ),

                MovieHorizontalListview(
                  movies: upcomingMovies,
                  title: 'Próximamente',
                  subTitle: "Noviembre",
                  loadNextPage: () =>
                      ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
                ),

                MovieHorizontalListview(
                  movies: popular,
                  title: 'Populares',
                  subTitle: "Noviembre",
                  loadNextPage: () =>
                      ref.read(popularMoviesProvider.notifier).loadNextPage(),
                ),

                MovieHorizontalListview(
                  movies: topRated,
                  title: 'Mejor valoradas',
                  subTitle: "Noviembre",
                  loadNextPage: () =>
                      ref.read(topratedMoviesProvider.notifier).loadNextPage(),
                ),

                MovieHorizontalListview(
                  movies: mexicanMovies,
                  title: 'Cine Mexicano',
                  subTitle: "Por fecha de estreno",
                  loadNextPage: () =>
                      ref.read(mexicanMoviesProvider.notifier).loadNextPage(),
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
