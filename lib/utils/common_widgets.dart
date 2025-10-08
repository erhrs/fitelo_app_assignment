import 'package:fitelo_app_assignment/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_colors.dart';
import 'app_text_style.dart';
import 'app_strings.dart';

class StepDots extends StatelessWidget {
  final int total;
  final int activeIndex;
  const StepDots({super.key, required this.total, required this.activeIndex,});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(total, (i) {
        final isActive = i == activeIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 25 : 10,
          height: 10,
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.primaryColor
                : AppColors.grey.withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(10),
          ),
        );
      }),
    );
  }
}


Widget dot() => Container(
  margin: const EdgeInsets.symmetric(horizontal: 4),
  width: 10,
  height: 10,
  decoration: BoxDecoration(
    color: AppColors.grey.withValues(alpha: 0.45),
    shape: BoxShape.circle,
  ),
);


Widget activeDot() => Container(
  margin: const EdgeInsets.symmetric(horizontal: 4),
  width: 25,
  height: 10,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: AppColors.primaryColor,
  ),
);

Widget bottomButtons({required void Function() onContinuePressed, VoidCallback? onBackPressed,}) {
  return Row(
    children: [
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: AppColors.primaryColor),
          onPressed: onBackPressed,
        ),
      ),
      10.width,
      Expanded(
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: onContinuePressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              AppStrings.continueBtnText,
              style: AppTextStyle.h4WhiteColor,
            ),
          ),
        ),
      ),
    ],
  );
}