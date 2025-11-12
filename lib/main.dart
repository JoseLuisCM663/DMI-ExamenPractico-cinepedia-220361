import 'package:cinemapedia_220361/config/router/app_router.dart';
import 'package:cinemapedia_220361/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Función principal que inicializa la aplicación Flutter.
///
/// **Configuraciones iniciales:**
/// - Carga variables de entorno desde archivo .env
/// - Configura ProviderScope para Riverpod
/// - Inicializa la aplicación con MaterialApp.router
///

Future<void> main() async {
  /// Carga las variables de entorno desde el archivo .env
  /// Necesario para acceder a API keys y configuraciones sensibles
  await dotenv.load(fileName: '.env');

  /// Inicia la aplicación envuelta en ProviderScope
  /// Esto permite el uso de Riverpod en toda la jerarquía de widgets
  runApp(const ProviderScope(child: MainApp()));
}

/// Widget raíz de la aplicación que configura el tema y la navegación.
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      /// Configuración de rutas usando GoRouter
      /// Maneja toda la navegación de la aplicación
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
    );
  }
}
