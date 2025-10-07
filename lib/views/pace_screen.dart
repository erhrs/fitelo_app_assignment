import 'package:fitelo_app_assignment/utils/app_texts.dart';
import 'package:fitelo_app_assignment/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/pace_controller.dart';
import '../routes/app_routes.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_style.dart';
import '../utils/common_widgets.dart';


class PaceScreen extends StatelessWidget {
  const PaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PaceController controller = Get.put(PaceController());

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              40.height,
              // Progress Dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [dot(true), dot(true), dot(false)],
              ),
              30.height,

              // Heading
              Text(
                "Great ⏳! We’ve calculated a safe, steady timeline—how soon do you want to reach your milestone?",
                textAlign: TextAlign.center,
                style: AppTextStyle.h4BlackColor,
              ),
              40.height,

              // Duration display
              Text(
                "Time to lose weight",
                style: AppTextStyle.body1.copyWith(color: Colors.grey.shade700),
              ),
              8.height,
              Obx(
                    () => Text(
                  "${controller.months.value.toStringAsFixed(1)} months",
                  style: AppTextStyle.h1.copyWith(fontSize: 36),
                ),
              ),
              40.height,

              // Segmented icons row
              Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _paceIcon(
                    icon: Icons.self_improvement_rounded,
                    selected:
                    controller.selectedPace.value == PaceType.gentle,
                    onTap: () => controller.selectPace(PaceType.gentle),
                  ),
                  _paceIcon(
                    icon: Icons.fitness_center_rounded,
                    selected: controller.selectedPace.value ==
                        PaceType.recommended,
                    onTap: () => controller.selectPace(PaceType.recommended),
                  ),
                  _paceIcon(
                    icon: Icons.speed_rounded,
                    selected:
                    controller.selectedPace.value == PaceType.intense,
                    onTap: () => controller.selectPace(PaceType.intense),
                  ),
                ],
              )),
              30.height,

              // Fine-tune slider
              Obx(
                    () => SliderTheme(
                  data: const SliderThemeData(
                    trackHeight: 5,
                    thumbShape:
                    RoundSliderThumbShape(enabledThumbRadius: 10),
                    overlayShape:
                    RoundSliderOverlayShape(overlayRadius: 18),
                  ),
                  child: Slider(
                    value: controller.months.value,
                    min: 1,
                    max: 12,
                    divisions: 22,
                    activeColor: AppColors.primaryColor,
                    inactiveColor: Colors.grey.shade200,
                    onChanged: (val) => controller.updateMonths(val),
                  ),
                ),
              ),

              Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _paceText(
                    label: "Gentle",
                    selected:
                    controller.selectedPace.value == PaceType.gentle,
                  ),
                  _paceText(
                    label: "Recommended",
                    selected: controller.selectedPace.value ==
                        PaceType.recommended,
                  ),
                  _paceText(
                    label: "Intense",
                    selected:
                    controller.selectedPace.value == PaceType.intense,
                  ),
                ],
              )),
              10.height,

              // Caption
              Obx(
                    () => Text(
                  controller.paceCaption,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.body2
                      .copyWith(color: Colors.grey.shade700),
                ),
              ),
              const Spacer(),

              // Bottom Buttons
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded,
                          color: AppColors.primaryColor),
                      onPressed: () => Get.back(),
                    ),
                  ),
                  10.width,
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => Get.toNamed(Routes.calorie),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          AppTexts.continueBtnText,
                          style: AppTextStyle.h4WhiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              25.height,
            ],
          ),
        ),
      ),
    );
  }

  Widget _paceIcon({
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: CircleAvatar(
          radius: 25,
          backgroundColor:
          selected ? AppColors.primaryColor.withValues(alpha: 0.15) : Colors.grey.shade100,
          child: Icon(icon,
              color:
              selected ? AppColors.primaryColor : Colors.grey.shade500,
              size: 26),
        ),
      ),
    );
  }

  Widget _paceText({
    required String label,
    required bool selected,
  }) {
    return Expanded(
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: selected ? AppColors.primaryColor : Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
