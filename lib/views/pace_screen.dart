import 'package:fitelo_app_assignment/utils/app_strings.dart';
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
              30.height,
              // Heading
              Text(
                AppStrings.paceHeading,
                textAlign: TextAlign.center,
                style: AppTextStyle.h4BlackColor,
              ),
              40.height,

              // Duration display
              Text(
                AppStrings.timeToLoseWeight,
                style: AppTextStyle.body1.copyWith(color: Colors.grey.shade700),
              ),
              8.height,
              Obx(() {
                final double monthsValue = controller.months.value;

                final String monthsString = monthsValue % 1 == 0
                    ? monthsValue.toInt().toString()
                    : monthsValue.toStringAsFixed(1);
                return Text(
                  "$monthsString ${AppStrings.months}",
                  style: AppTextStyle.h1.copyWith(fontSize: 36),
                );
              }),
              40.height,

              // Segmented icons row
              Obx(
                () => Row(
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
                      selected:
                          controller.selectedPace.value == PaceType.recommended,
                      onTap: () => controller.selectPace(PaceType.recommended),
                    ),
                    _paceIcon(
                      icon: Icons.speed_rounded,
                      selected:
                          controller.selectedPace.value == PaceType.intense,
                      onTap: () => controller.selectPace(PaceType.intense),
                    ),
                  ],
                ),
              ),
              30.height,

              // Fine-tune slider
              Obx(
                () => SliderTheme(
                  data: const SliderThemeData(
                    trackHeight: 5,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 18),
                  ),
                  child: Slider(
                    value: controller.months.value,
                    min: 1,
                    max: 12,
                    activeColor: AppColors.primaryColor,
                    inactiveColor: Colors.grey.shade200,
                    onChanged: (val) {
                      // Snap to nearest 0.5 step
                      double stepped = (val * 2).round() / 2;
                      if (stepped != controller.months.value) {
                        controller.updateMonths(stepped);
                      }
                    },
                  ),
                ),
              ),

              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _paceText(
                      label: AppStrings.gentle,
                      selected:
                          controller.selectedPace.value == PaceType.gentle,
                    ),
                    _paceText(
                      label: AppStrings.recommended,
                      selected:
                          controller.selectedPace.value == PaceType.recommended,
                    ),
                    _paceText(
                      label: AppStrings.intense,
                      selected:
                          controller.selectedPace.value == PaceType.intense,
                    ),
                  ],
                ),
              ),
              20.height,

              // Caption
              Obx(
                () => AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Text(
                    controller.paceCaption,
                    key: UniqueKey(),
                    textAlign: TextAlign.center,
                    style: AppTextStyle.body2.copyWith(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
              const Spacer(),
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
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selected
                ? AppColors.primaryColor.withValues(alpha: 0.15)
                : Colors.grey.shade100,
          ),
          padding: const EdgeInsets.all(10),
          child: Icon(
            icon,
            color: selected ? AppColors.primaryColor : Colors.grey.shade500,
            size: 26,
          ),
        ),
      ),
    );
  }

  Widget _paceText({required String label, required bool selected}) {
    return Expanded(
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: selected ? AppColors.primaryColor : Colors.black,
        ),
        textAlign: TextAlign.center,
        child: Text(label),
      ),
    );
  }
}
