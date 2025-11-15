import 'dart:async';
import 'package:flutter/material.dart';

class FullscreenLoader extends StatefulWidget {
  const FullscreenLoader({super.key});

  @override
  State<FullscreenLoader> createState() => _FullscreenLoaderState();
}

class _FullscreenLoaderState extends State<FullscreenLoader> {
  final List<String> messages = [
    'Estableciendo elementos de comunicación',
    'Conectando a la API de TheMovieDB',
    'Obteniendo las películas que actualmente se proyectan',
    'Obteniendo los próximos estrenos',
    'Obteniendo las películas mejor valoradas',
    'Obteniendo las mejores películas Mexicanas',
    'Todo listo...comencemos',
  ];

  double progress = 0.0;
  int index = 0;

  @override
  void initState() {
    super.initState();
    _simulateProgress();
  }

  /// Simula el progreso mientras los providers cargan datos
  void _simulateProgress() {
    Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      if (index >= messages.length) {
        timer.cancel();
        return;
      }

      setState(() {
        index++;
        progress = index / messages.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorPrimary = const Color(0xFFE50914); // rojo estilo logo
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

              /// Barra progresiva
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: LinearProgressIndicator(
                  value: progress, // <-- AQUÍ YA NO USAMOS NULL
                  minHeight: 12,
                  backgroundColor: Colors.black12,
                  valueColor: AlwaysStoppedAnimation<Color>(colorPrimary),
                ),
              ),

              const SizedBox(height: 15),

              /// Porcentaje mostrado
              Text(
                "${(progress * 100).toInt()}%",
                style: TextStyle(
                  fontSize: 18,
                  color: colorPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 25),

              /// Mensajes dinámicos
              Text(
                messages[index == 0 ? 0 : index - 1],
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
