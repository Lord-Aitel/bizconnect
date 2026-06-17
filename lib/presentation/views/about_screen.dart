import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Acerca de")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("BizConnect", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Aplicación desarrollada para digitalizar flujos de negocio locales."),
            SizedBox(height: 20),
            Text("Créditos:"),
            Text("- mati"),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
