import 'package:flutter/material.dart';

class FullscreenLoader extends StatelessWidget {
  const FullscreenLoader({super.key});
  Stream<String> getLoadingMessages() {
    final messages = <String>[
      'Estableciendo elementos de comunicación',
      'Conectando a la API de TheMovieDB',
      'Obteniendo las películas que actualmente se proyectan',
      'Obteniendo los proximos estrenos',
      'Obteniendo las peliculas mejor valoradas',
      'Obteniendo las mejores películas Mexicanas',
      'Todo listo...comencemos',
    ];
    return Stream.periodic(const Duration(milliseconds: 3000), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Bienvenid@ a Cinemapedia 220361'),
          const SizedBox(height: 10),
          const CircularProgressIndicator(strokeWidth: 4),
          const SizedBox(height: 10),
          StreamBuilder<String>(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Text('Cargando...');
              }
              return Text(snapshot.data!);
            },
          ),
        ],
      ),
    );
  }
}
