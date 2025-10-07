import 'dart:math';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'dart:math';
import 'package:flutter/material.dart';

class RingChart extends StatelessWidget {
  final double calories;
  final double carbs;
  final double protein;
  final double fat;

  const RingChart({
    super.key,
    required this.calories,
    required this.carbs,
    required this.protein,
    required this.fat,
  });

  @override
  Widget build(BuildContext context) {
    double total = carbs + protein + fat;
    final carbsRatio = carbs / total;
    final proteinRatio = protein / total;
    final fatRatio = fat / total;

    return CustomPaint(
      size: const Size(220, 220),
      painter: _RingChartPainter(
        carbsRatio: carbsRatio,
        proteinRatio: proteinRatio,
        fatRatio: fatRatio,
      ),
      child: SizedBox(
        height: 220,
        width: 220,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.local_fire_department, color: Colors.orange, size: 26),
              const SizedBox(height: 4),
              Text(
                calories.toStringAsFixed(0),
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              const Text(
                "Daily calories",
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RingChartPainter extends CustomPainter {
  final double carbsRatio;
  final double proteinRatio;
  final double fatRatio;

  _RingChartPainter({
    required this.carbsRatio,
    required this.proteinRatio,
    required this.fatRatio,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final center = rect.center;
    final radius = size.width / 2.5;

    // Background ring
    final paintBg = Paint()
      ..color = Colors.grey.shade200
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, paintBg);

    double startAngle = -pi / 2;

    // Helper: draw arc + icon
    void drawArcWithIcon(Color color, double ratio, IconData icon) {
      final sweep = 2 * pi * ratio;
      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 20
        ..strokeCap = StrokeCap.round;
      final rect = Rect.fromCircle(center: center, radius: radius);
      canvas.drawArc(rect, startAngle, sweep, false, paint);

      // Draw icon at arc midpoint
      final midAngle = startAngle + sweep / 2;
      final iconOffsetRadius = radius + 18; // distance from center to icon
      final iconX = center.dx + cos(midAngle) * iconOffsetRadius;
      final iconY = center.dy + sin(midAngle) * iconOffsetRadius;

      // Draw icon
      final textPainter = TextPainter(
        text: TextSpan(
          text: String.fromCharCode(icon.codePoint),
          style: TextStyle(
            fontSize: 20,
            fontFamily: icon.fontFamily,
            color: color,
            package: icon.fontPackage,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(iconX - textPainter.width / 2, iconY - textPainter.height / 2),
      );

      startAngle += sweep;
    }

    // Carbs arc
    drawArcWithIcon(Colors.teal, carbsRatio, Icons.bakery_dining_rounded);

    // Protein arc
    drawArcWithIcon(Colors.blueAccent, proteinRatio, Icons.fitness_center_rounded);

    // Fat arc
    drawArcWithIcon(Colors.orangeAccent, fatRatio, Icons.egg_rounded);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
