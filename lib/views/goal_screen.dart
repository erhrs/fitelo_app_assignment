import 'package:fitelo_app_assignment/services/storage_service.dart';
import 'package:fitelo_app_assignment/utils/app_colors.dart';
import 'package:fitelo_app_assignment/utils/app_text_style.dart';
import 'package:fitelo_app_assignment/utils/app_texts.dart';
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
              40.height,
              // Progress dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [dot(true), dot(false), dot(false)],
              ),
              30.height,
              Text(
                AppTexts.goalTextHeading,
                textAlign: TextAlign.center,
                style: AppTextStyle.h4BlackColor,
              ),
              25.height,
              Text(
                AppTexts.yourWeightLossGoal,
                style: AppTextStyle.body1.copyWith(color: Colors.grey.shade700),
              ),
              Obx(
                () => Text(
                  "${controller.goalKg.value.toStringAsFixed(0)}kg",
                  style: AppTextStyle.h1.copyWith(fontSize: 35),
                ),
              ),
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
                  border: Border.all(color: AppColors.lightGrey.withValues(alpha: 0.1))
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
                          AppTexts.recommended,
                          style: AppTextStyle.h4PrimaryColor.copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                    10.height,
                    Text(
                      AppTexts.goalRecommendedText,
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
                        AppTexts.youCanStartWith0AndUpdateLater,
                        style: AppTextStyle.body2,
                      )
                    : const SizedBox.shrink(),
              ),
              15.height,
              // Bottom buttons
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => Get.toNamed(Routes.pace),
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
}
