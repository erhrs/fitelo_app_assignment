import 'package:fitelo_app_assignment/utils/app_colors.dart';
import 'package:fitelo_app_assignment/utils/app_icons.dart';
import 'package:fitelo_app_assignment/utils/app_text_style.dart';
import 'package:fitelo_app_assignment/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/calorie_controller.dart';
import '../utils/app_strings.dart';
import '../utils/common_widgets.dart';
import '../widgets/ring_chart.dart';
import '../widgets/macro_card.dart';

class CalorieScreen extends StatelessWidget {
  const CalorieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CalorieController());
    final maintenanceCtrl = TextEditingController(
      text: controller.maintenanceCalories.value.toStringAsFixed(0),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Obx(
            () => SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  30.height,
                  Text(
                    AppStrings.calorieHeading
                        .replaceFirst(
                          "{goal}",
                          controller.goalKg.value.toString(),
                        )
                        .replaceFirst(
                          "{months}",
                          controller.months.value.toStringAsFixed(0),
                        ),
                    textAlign: TextAlign.center,
                    style: AppTextStyle.h4BlackColor,
                  ),
                  30.height,

                  RingChart(
                    carbs: controller.carbs.value,
                    protein: controller.protein.value,
                    fat: controller.fat.value,
                    calories: controller.dailyCalories.value,
                  ),
                  15.height,
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.local_fire_department_rounded,
                          color: AppColors.primaryColor,
                          size: 26,
                        ),
                        12.width,
                        Expanded(
                          child: TextField(
                            maxLength: 7,
                            keyboardType: TextInputType.number,
                            controller: maintenanceCtrl,
                            style: AppTextStyle.h4BlackColor,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: const InputDecoration(
                              labelText: AppStrings.maintenanceCalories,
                              labelStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              counterText: '',
                            ),
                            onChanged: (val) {
                              if (val.isNotEmpty) {
                                final parsed = double.tryParse(val);
                                if (parsed != null) {
                                  controller.updateMaintenance(parsed);
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  30.height,
                  Row(
                    children: [
                      MacroCard(
                        label: AppStrings.carbs,
                        grams: controller.carbs.value,
                        iconBgColor: Colors.teal,
                        iconPath: AppIcons.carbs,
                      ),
                      MacroCard(
                        label: AppStrings.protein,
                        grams: controller.protein.value,
                        iconPath: AppIcons.protein,
                        iconBgColor: Colors.blueAccent,
                      ),
                      MacroCard(
                        label: AppStrings.fat,
                        grams: controller.fat.value,
                        iconBgColor: Colors.orangeAccent,
                        iconPath: AppIcons.fat,
                      ),
                    ],
                  ),
                  100.height,
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.lightGrey,
        onPressed: () => _showInfoSheet(context),
        child: const Icon(Icons.info_outline, color: AppColors.primaryColor),
      ),
    );
  }

  void _showInfoSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: AppColors.white,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.howCaloriesCalculated,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            12.height,
            Text(
              AppStrings.caloriesInfo,
              style: TextStyle(fontSize: 15, color: Colors.black87),
            ),
            50.height
          ],
        ),
      ),
    );
  }
}
