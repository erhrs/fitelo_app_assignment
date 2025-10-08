import 'dart:math';
import 'package:fitelo_app_assignment/utils/app_colors.dart';
import 'package:fitelo_app_assignment/utils/app_icons.dart';
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
    final total = carbs + protein + fat;
    final carbsRatio = carbs / total;
    final proteinRatio = protein / total;
    final fatRatio = fat / total;

    return SizedBox(
      height: 220,
      width: 220,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // RING CHART
          CustomPaint(
            size: const Size(220, 220),
            painter: _RingChartPainter(
              carbsRatio: carbsRatio,
              proteinRatio: proteinRatio,
              fatRatio: fatRatio,
            ),
          ),

          // CENTER TEXT
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.local_fire_department,
                  color: Colors.orange, size: 28),
              const SizedBox(height: 6),
              Text(
                calories.toStringAsFixed(0),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Text(
                "Daily calories",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          // ICONS ABOVE RING
          _buildIcon(
            angle: -pi / 2 + carbsRatio * pi,
            color: Colors.teal,
            imagePath: AppIcons.carbs,
          ),
          _buildIcon(
            angle: -pi / 2 + (carbsRatio + proteinRatio / 2) * 2 * pi,
            color: Colors.blueAccent,
            imagePath: AppIcons.protein,
          ),
          _buildIcon(
            angle: -pi / 2 + (carbsRatio + proteinRatio + fatRatio / 2) * 2 * pi,
            color: Colors.orangeAccent,
            imagePath: AppIcons.fat,
          ),
        ],
      ),
    );
  }

  /// Builds a circular icon bubble (with white border) positioned above the ring
  static Widget _buildIcon({
    required double angle,
    required Color color,
    required String imagePath,
  }) {
    const double ringRadius = 88.0; // should match painter’s radius + offset
    final offset =
    Offset(cos(angle) * (ringRadius), sin(angle) * (ringRadius));

    return Transform.translate(
      offset: offset,
      child: Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: Border.all(color: Colors.white, width: 3),
        ),
        padding: const EdgeInsets.all(6),
        child: Image.asset(
          imagePath,
          color: AppColors.white,
          fit: BoxFit.contain,
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
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, paintBg);

    double startAngle = -pi / 2;

    void drawArc(Color color, double ratio) {
      final sweep = 2 * pi * ratio;
      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 10
        ..strokeCap = StrokeCap.round;
      final arcRect = Rect.fromCircle(center: center, radius: radius);
      canvas.drawArc(arcRect, startAngle, sweep, false, paint);
      startAngle += sweep;
    }

    // arcs
    drawArc(Colors.teal, carbsRatio);
    drawArc(Colors.blueAccent, proteinRatio);
    drawArc(Colors.orangeAccent, fatRatio);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
