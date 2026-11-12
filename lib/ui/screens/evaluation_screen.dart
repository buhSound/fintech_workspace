import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../services/device_interop_service.dart';

class EvaluationScreen extends StatefulWidget {
  const EvaluationScreen({super.key});

  @override
  State<EvaluationScreen> createState() => _EvaluationScreenState();
}

class _EvaluationScreenState extends State<EvaluationScreen> {
  Map<String, dynamic>? _evaluationData;
  final Map<String, int> _ratings = {}; // Guarda { "HU-01": 5, "UX-01": 4, ... }

  @override
  void initState() {
    super.initState();
    _loadEvaluationData();
  }

  // Carga y decodifica el JSON desde los assets
  Future<void> _loadEvaluationData() async {
    final String response = await rootBundle.loadString('assets/dataFold/evaluation.json');
    final data = await json.decode(response);
    setState(() {
      _evaluationData = data;
    });
  }

  // Compila el texto y dispara el Intent Nativo
  void _submitFeedback() {
    int totalQuestions = 0;
    _evaluationData?.values.forEach((category) {
      totalQuestions += (category as List).length;
    });

    if (_ratings.length < totalQuestions) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, califica todas las preguntas antes de enviar.')),
      );
      return;
    }

    final buffer = StringBuffer();
    buffer.writeln('📋 Feedback de Evaluación - Fintech Workspace\n');

    _evaluationData?.forEach((categoryName, questions) {
      buffer.writeln('--- ${categoryName.toUpperCase().replaceAll('_', ' ')} ---');
      for (var q in questions) {
        final id = q['id'];
        final title = q['titulo'];
        final score = _ratings[id] ?? 0;
        buffer.writeln('$title\n⭐ Puntuación: $score/5\n');
      }
    });

    final interop = context.read<DeviceInteropService>();
    interop.shareContent(buffer.toString(), subject: 'Resultados de Evaluación de Usuario');

    // Regresamos al menú principal
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('¡Gracias por tu evaluación!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Evaluar Aplicación')),
      body: _evaluationData == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Ayúdanos a mejorar calificando tu experiencia en las siguientes áreas.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),

          // Iteramos sobre las categorías del JSON
          ..._evaluationData!.entries.map((category) {
            final categoryName = category.key.toUpperCase().replaceAll('_', ' ');
            final questions = category.value as List;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  categoryName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),

                // Iteramos sobre las preguntas de cada categoría
                ...questions.map((q) => _buildQuestionCard(q)).toList(),
                const Divider(height: 32),
              ],
            );
          }),

          ElevatedButton.icon(
            onPressed: _submitFeedback,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            icon: const Icon(Icons.send),
            label: const Text('Enviar Evaluación', style: TextStyle(fontSize: 16)),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(Map<String, dynamic> question) {
    final id = question['id'];
    final currentRating = _ratings[id] ?? 0;

    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerLowest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(question['titulo'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 12),

            // Selector de estrellas
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(5, (index) {
                final starValue = index + 1;
                return IconButton(
                  icon: Icon(
                    starValue <= currentRating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 32,
                  ),
                  onPressed: () {
                    setState(() {
                      _ratings[id] = starValue;
                    });
                  },
                );
              }),
            ),

            // Textos min/max de ayuda visual
            const SizedBox(height: 8),
            Text(question['min'], style: const TextStyle(fontSize: 12, color: Colors.grey)),
            Text(question['max'], style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}