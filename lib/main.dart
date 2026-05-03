import 'package:flutter/material.dart';
import 'package:bizconnect/splash_screen.dart';
import 'views/navigation.dart';

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
      // Pantalla inicial será el Splash
      home: const SplashScreen(),
      routes: {
        '/home': (context) => const NavigationScreen(),
      },
    );
  }
}
