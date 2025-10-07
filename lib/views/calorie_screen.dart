import 'package:fitelo_app_assignment/utils/app_text_style.dart';
import 'package:fitelo_app_assignment/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/calorie_controller.dart';
import '../utils/common_widgets.dart';
import '../widgets/ring_chart.dart';
import '../widgets/macro_card.dart';

class CalorieScreen extends StatelessWidget {
  const CalorieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CalorieController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                40.height,
                // Progress dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [dot(false), dot(false), dot(true)],
                ),
                30.height,
                Text(
                  "Awesome 😎! Here's Your Calorie Intake - with your “${controller.goalKg.value} kg in ${controller.months.value} months” goal, this personalized daily calorie guide keeps you on track!",
                  textAlign: TextAlign.center,
                  style: AppTextStyle.h4BlackColor,
                ),
                const SizedBox(height: 30),

                RingChart(
                  // value: controller.dailyCalories.value,
                  carbs: controller.carbs.value,
                  protein: controller.protein.value,
                  fat: controller.fat.value,
                  calories: controller.dailyCalories.value,
                ),

                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MacroCard(
                      label: "Carbs",
                      grams: controller.carbs.value,
                      color: const Color(0xFFB0E0E6),
                    ),
                    MacroCard(
                      label: "Protein",
                      grams: controller.protein.value,
                      color: const Color(0xFFCCE5FF),
                    ),
                    MacroCard(
                      label: "Fat",
                      grams: controller.fat.value,
                      color: const Color(0xFFFFE5B4),
                    ),
                  ],
                ),

                const Spacer(),

                // Continue Button
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.orange),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.orange,
                        ),
                        onPressed: () => Get.back(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF58B56),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            "Continue",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.shade100,
        onPressed: () => _showInfoSheet(context),
        child: const Icon(Icons.info_outline, color: Colors.black87),
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
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
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
              style: TextStyle(fontSize: 15, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
