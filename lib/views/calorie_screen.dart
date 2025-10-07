import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/calorie_controller.dart';
import '../widgets/ring_chart.dart';
import '../widgets/macro_card.dart';

class CalorieScreen extends StatelessWidget {
  const CalorieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CalorieController controller = Get.put(CalorieController());
    controller.calculateCalories();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Calorie Target"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showInfoSheet(context),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() => Column(
            children: [
              const SizedBox(height: 20),
              RingChart(value: controller.dailyCalories.value),
              const SizedBox(height: 30),

              // Maintenance input
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Maintenance: ",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    width: 80,
                    child: TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(8),
                      ),
                      onChanged: (val) {
                        final parsed = double.tryParse(val) ?? 2200;
                        controller.updateMaintenance(parsed);
                      },
                    ),
                  ),
                  const Text(" kcal"),
                ],
              ),

              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MacroCard(label: "Carbs", grams: controller.carbs.value, color: Colors.blue),
                  MacroCard(label: "Protein", grams: controller.protein.value, color: Colors.green),
                  MacroCard(label: "Fat", grams: controller.fat.value, color: Colors.pink),
                ],
              ),
            ],
          )),
        ),
      ),
    );
  }

  void _showInfoSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "How Calories Are Calculated",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                "1. Energy per kg fat = 7700 kcal\n"
                    "2. Total deficit = goal × 7700\n"
                    "3. Days = months × 30.4\n"
                    "4. Daily deficit = total_deficit / days\n"
                    "5. Daily calories = maintenance - daily_deficit (min 1200)\n"
                    "6. Macros: 45% carbs, 30% protein, 25% fat\n"
                    "7. Grams: carbs/protein ÷4, fat ÷9",
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
