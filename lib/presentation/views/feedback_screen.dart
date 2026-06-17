import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  Map<String, dynamic>? feedbackData;

  @override
  void initState() {
    super.initState();
    cargarFeedback();
  }

  Future<void> cargarFeedback() async {
    try {
      final data = await rootBundle.loadString('assets/feedback.json');
      setState(() {
        feedbackData = json.decode(data);
      });
    } catch (e) {
      debugPrint("Error al cargar feedback.json: $e");
    }
  }

  Future<void> enviarFeedbackPorCorreo() async {
    if (feedbackData == null) return;

    final texto = feedbackData!.entries.map((e) {
      return "${e.key.toUpperCase()}:\n${(e.value as List)
          .map((p) => "- ${p['titulo']}: ${p['valor']} estrellas")
          .join("\n")}";
    }).join("\n\n");

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'mpeters22@alumnos.utalca.cl', // 🔹 tu correo
      queryParameters: {
        'subject': 'Feedback BizConnect',
        'body': texto,
      },
    );

    try {
      // 🔹 Se elimina el chequeo con canLaunchUrl y se fuerza apertura externa
      await launchUrl(
        emailUri,
        mode: LaunchMode.externalApplication,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cliente de correo abierto correctamente")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al intentar abrir correo: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (feedbackData == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Encuesta de Feedback")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: feedbackData!.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.key.toUpperCase(),
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ...List<Widget>.from((entry.value as List).map((pregunta) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(pregunta['titulo']),
                    Slider(
                      value: (pregunta['valor'] as num).toDouble(),
                      min: 0,
                      max: 5,
                      divisions: 5,
                      label: "${pregunta['valor']} estrellas",
                      onChanged: (val) {
                        setState(() {
                          pregunta['valor'] = val.round();
                        });
                      },
                    ),
                    const Divider(),
                  ],
                );
              })),
              const SizedBox(height: 16),
            ],
          );
        }).toList(),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton.icon(
            icon: const Icon(Icons.send),
            label: const Text("Enviar Feedback por correo"),
            onPressed: enviarFeedbackPorCorreo,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
            ),
          ),
        ),
      ),
    );
  }
}
