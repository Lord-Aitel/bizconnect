import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bizconnect/data/sources/firebase_options.dart';

// Importa tus pantallas
import 'presentation/views/splash_screen.dart';
import 'presentation/views/locales_screen.dart';
import 'presentation/views/product_list.dart';
import 'presentation/views/product_detail.dart';
import 'domain/entities/product.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BizConnect',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 2, 18, 162)),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      routes: {
        '/home': (context) => const LocalesScreen(),
        '/productos': (context) {
          final localId = ModalRoute.of(context)!.settings.arguments as String;
          return ProductList(localId: localId);
        },
        '/detalle': (context) {
          final product = ModalRoute.of(context)!.settings.arguments as Product;
          return ProductDetail(product: product);
        },
      },
    );
  }
}
