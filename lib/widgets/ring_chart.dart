import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class RingChart extends StatelessWidget {
  final double value;
  const RingChart({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    double percent = value / 3000;
    if (percent > 1) percent = 1;

    return CircularPercentIndicator(
      radius: 90,
      lineWidth: 14,
      percent: percent,
      animation: true,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value.toStringAsFixed(0),
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.orange),
          ),
          const Text("kcal / day", style: TextStyle(color: Colors.grey)),
        ],
      ),
      progressColor: Colors.orange,
      backgroundColor: Colors.orange.shade100,
      circularStrokeCap: CircularStrokeCap.round,
    );
  }
}
