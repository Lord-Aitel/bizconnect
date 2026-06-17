import 'dart:convert';
import 'package:flutter/services.dart';

class FeedbackService {
  Future<Map<String, dynamic>> cargarFeedback() async {
    final data = await rootBundle.loadString('assets/feedback.json');
    return json.decode(data);
  }
}
