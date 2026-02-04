import 'package:flutter/material.dart';
import 'package:proyecto_gr/views/splash_view.dart';
// import 'views/splash_view.dart'; // Descoméntalo si vas a usar el Splash primero

// Notificador global para el cambio de tema
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Rutas Cali',
          
          // --- TEMA CLARO ---
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF01579B),
              brightness: Brightness.light,
            ),
          ),

          // --- TEMA OSCURO (Optimizado para alto contraste) ---
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF121212), // Fondo negro profundo
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF01579B),
              brightness: Brightness.dark,
              surface: const Color(0xFF1E1E1E), // Fondo de tarjetas/paneles
              onSurface: Colors.white,           // Blanco puro para textos sobre fondo
              primary: const Color(0xFF4FC3F7),  // Un azul más claro para que resalte en oscuro
            ),
            // Forzamos que los estilos de texto sean blancos por defecto
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.white),
              bodyMedium: TextStyle(color: Colors.white),
              titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            // Estilo para los íconos en modo oscuro
            iconTheme: const IconThemeData(color: Colors.white),
          ),

          themeMode: currentMode,
          
          // Cambia a SplashView() si quieres que inicie con la carga
          home: const SplashView(), 
        );
      },
    );
  }
}