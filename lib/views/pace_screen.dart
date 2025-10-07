import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/pace_controller.dart';
import '../routes/app_routes.dart';

class PaceScreen extends StatelessWidget {
  const PaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PaceController controller = Get.put(PaceController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Your Pace"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 20),
              Obx(() => Text(
                "${controller.months.value.toStringAsFixed(1)} months",
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              )),
              const SizedBox(height: 20),

              // Preset Segmented Buttons
              Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildPaceButton(controller, PaceType.gentle, "Gentle"),
                  _buildPaceButton(controller, PaceType.recommended, "Recommended"),
                  _buildPaceButton(controller, PaceType.intense, "Intense"),
                ],
              )),
              const SizedBox(height: 30),

              // Fine-tune slider
              Obx(() => Slider(
                value: controller.months.value,
                min: 1,
                max: 12,
                divisions: 22, // steps of 0.5
                activeColor: Colors.orange,
                label: "${controller.months.value.toStringAsFixed(1)} months",
                onChanged: (val) => controller.updateMonths(val),
              )),
              const SizedBox(height: 10),

              // Caption
              Obx(() => Text(
                controller.paceCaption,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              )),

              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.toNamed(Routes.calorie),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaceButton(PaceController controller, PaceType type, String label) {
    final bool isSelected = controller.selectedPace.value == type;
    return GestureDetector(
      onTap: () => controller.selectPace(type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
