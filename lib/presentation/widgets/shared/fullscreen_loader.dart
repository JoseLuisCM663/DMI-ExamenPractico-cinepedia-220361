import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia_220361/presentation/providers/movies/loader_progress_provider.dart';

class FullscreenLoader extends ConsumerWidget {
  const FullscreenLoader({super.key});

  final List<String> messages = const [
    'Estableciendo elementos de comunicación',
    'Conectando a la API de TheMovieDB',
    'Obteniendo las películas que actualmente se proyectan',
    'Obteniendo los próximos estrenos',
    'Obteniendo las películas mejor valoradas',
    'Obteniendo las mejores películas Mexicanas',
    'Todo listo... comencemos',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(loaderProgressProvider);

    /// Determinar qué mensaje se mostrará según el progreso real del provider
    final maxIndex = messages.length - 1;
    int index = (progress * maxIndex).clamp(0, maxIndex).round();
    final currentMessage = messages[index];

    final colorPrimary = const Color(0xFFE50914); // rojo estilo Cinemapedia
    final colorDark = Colors.black87;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Bienvenid@ a Cinemapedia 220361",
                style: TextStyle(
                  fontSize: 20,
                  color: colorDark,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

              /// BARRA DE PROGRESO REAL
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progress == 0 ? 0.01 : progress,
                  minHeight: 12,
                  backgroundColor: Colors.black12,
                  valueColor: AlwaysStoppedAnimation<Color>(colorPrimary),
                ),
              ),

              const SizedBox(height: 15),

              /// PORCENTAJE MÁS LIMPIO
              Text(
                "${(progress * 100).toInt()}%",
                style: TextStyle(
                  fontSize: 16,
                  color: colorPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 25),

              /// MENSAJE ACTUAL DINÁMICO
              Text(
                currentMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: colorDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
