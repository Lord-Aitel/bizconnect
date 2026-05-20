import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Importa tus pantallas
import 'presentation/views/splash_screen.dart';
import 'presentation/views/navigation.dart';
import 'presentation/views/productos_screen.dart';
import 'presentation/views/locales_screen.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BizConnect',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // 🔹 Pantalla inicial: LocalesScreen (datos locales simulados)
      home: const LocalesScreen(),

      // 🔹 Definimos rutas dinámicas
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/productos':
            final args = settings.arguments as Map<String, dynamic>?;

            final String localId = args?['localId'] ?? "cafe_futrono";
            final List<Map<String, dynamic>> productos =
                args?['productos'] ?? [];

            return MaterialPageRoute(
              builder: (context) => ProductosScreen(
                localId: localId,
                productos: productos,
              ),
            );
        }
        return null;
      },
    );
  }
}
