import 'package:flutter/material.dart';

class SeriesDetailScreen extends StatelessWidget {
  static const String name = 'series-detail-screen';

  final String seriesId;

  const SeriesDetailScreen({
    super.key,
    required this.seriesId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle de Serie"),
      ),
      body: _SeriesView(seriesId: seriesId),
    );
  }
}

class _SeriesView extends StatelessWidget {
  final String seriesId;

  const _SeriesView({required this.seriesId});

  @override
  Widget build(BuildContext context) {
    // TODO: conectar provider para cargar detalle de la serie
    // final series = ref.watch(seriesProvider(seriesId));

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// --- POSTER / PORTADA ---
          Container(
            height: 350,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Center(
              child: Text(
                "Poster de la serie",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
          ),

          const SizedBox(height: 20),

          /// --- TITULO ---
          Text(
            "Título de la Serie",
            style: Theme.of(context).textTheme.headlineSmall,
          ),

          const SizedBox(height: 10),

          /// --- DESCRIPCIÓN ---
          const Text(
            "Descripción de la serie. Aquí aparecerá la sinopsis completa.",
            style: TextStyle(fontSize: 16),
          ),

          const SizedBox(height: 20),

          /// --- INFORMACIÓN EXTRA ---
          const Text(
            "Información adicional:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          const Text("• Fecha de estreno: ???"),
          const Text("• Número de temporadas: ???"),
          const Text("• Popularidad: ???"),
          const Text("• Lenguaje original: ???"),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
