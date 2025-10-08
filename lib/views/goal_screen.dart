import 'package:fitelo_app_assignment/services/storage_service.dart';
import 'package:fitelo_app_assignment/utils/app_colors.dart';
import 'package:fitelo_app_assignment/utils/app_text_style.dart';
import 'package:fitelo_app_assignment/utils/app_strings.dart';
import 'package:fitelo_app_assignment/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/goal_controller.dart';
import '../routes/app_routes.dart';
import '../utils/common_widgets.dart';
import '../widgets/custom_dial.dart';

class GoalScreen extends StatelessWidget {
  const GoalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GoalController controller = Get.put(GoalController());
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              30.height,
              Text(
                AppStrings.goalTextHeading,
                textAlign: TextAlign.center,
                style: AppTextStyle.h4BlackColor,
              ),
              25.height,
              Text(
                AppStrings.yourWeightLossGoal,
                style: AppTextStyle.body1.copyWith(color: Colors.grey.shade700),
              ),
              Obx(() {
                final double goalKgValue = controller.goalKg.value;
                final String weightString = goalKgValue % 1 == 0
                    ? goalKgValue.toInt().toString()
                    : goalKgValue.toStringAsFixed(1);

                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    // Combines fade + slight slide for smooth numeric transition
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.0, 0.2), // from slightly below
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeInOutBack,
                        )),
                        child: child,
                      ),
                    );
                  },
                  child: Text(
                    "${weightString}Kg",
                    key: ValueKey(weightString),
                    style: AppTextStyle.h1.copyWith(fontSize: 35),
                  ),
                );
              }),

              10.height,
              // Arc Dial Picker
              CustomDial(
                minValue: 0,
                maxValue: 40,
                step: 0.1,
                initialValue: StorageService.getGoal(),
                onChanged: (v) => controller.setGoal(v),
              ),

              // Recommended hint card
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: AppColors.grey.withValues(alpha: 0.5),
                  ),
                ),
                padding: const EdgeInsets.all(16),
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.thumb_up_alt_rounded,
                          color: AppColors.primaryColor,
                          size: 22,
                        ),
                        5.width,
                        Text(
                          AppStrings.recommended,
                          style: AppTextStyle.h4PrimaryColor.copyWith(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    10.height,
                    Text(
                      AppStrings.goalRecommendedText,
                      style: AppTextStyle.body2.copyWith(
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // subtle 0kg note
              Obx(
                () => controller.goalKg.value == 0
                    ? Text(
                        AppStrings.youCanStartWith0AndUpdateLater,
                        style: AppTextStyle.body2,
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
