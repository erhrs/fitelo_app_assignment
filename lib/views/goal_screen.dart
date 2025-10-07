import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/goal_controller.dart';
import '../routes/app_routes.dart';
import '../widgets/custom_dial.dart';

class GoalScreen extends StatelessWidget {
  const GoalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GoalController controller = Get.put(GoalController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              // Progress dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _dot(true),
                  _dot(false),
                  _dot(false),
                ],
              ),

              const SizedBox(height: 30),

              const Text(
                "Based on your height and weight,\n"
                    "here’s a goal 🎯 crafted just for you.\nReady to start your journey?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 30),
              const Text(
                "Your weight loss goal",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 8),
              Obx(() => Text(
                "${controller.goalKg.value.toStringAsFixed(1)} kg",
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              )),

              const SizedBox(height: 30),

              // Arc Dial Picker
              CustomDial(
                minValue: 0,
                maxValue: 40,
                step: 0.1,
                initialValue: 0,
                onChanged: (v) => controller.goalKg.value = v,
              ),

              // const SizedBox(height: 30),

              // Recommended hint card
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF4E6),
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Icon(Icons.thumb_up_alt_rounded,
                        color: Colors.orange, size: 22),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Recommended\nMost users (90%) follow our plan — it’s your turn to shine!",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // subtle 0kg note
              Obx(() => controller.goalKg.value == 0
                  ? const Text(
                "You can start with 0 and update later.",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              )
                  : const SizedBox.shrink()),

              const SizedBox(height: 16),

              // Bottom buttons
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded,
                          color: Colors.orange),
                      onPressed: () => Get.back(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => Get.toNamed(Routes.pace),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Continue",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dot(bool active) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 4),
    width: 10,
    height: 10,
    decoration: BoxDecoration(
      color: active ? Colors.orange : Colors.grey.shade300,
      shape: BoxShape.circle,
    ),
  );
}
