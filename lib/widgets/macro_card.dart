import 'package:flutter/material.dart';

class MacroCard extends StatelessWidget {
  final String label;
  final double grams;
  final Color color;

  const MacroCard({
    super.key,
    required this.label,
    required this.grams,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: color)),
            const SizedBox(height: 4),
            Text("${grams.toStringAsFixed(0)} g", style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
