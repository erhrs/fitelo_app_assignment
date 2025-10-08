import 'package:fitelo_app_assignment/utils/app_colors.dart';
import 'package:fitelo_app_assignment/utils/app_text_style.dart';
import 'package:fitelo_app_assignment/utils/extensions.dart';
import 'package:flutter/material.dart';

class MacroCard extends StatelessWidget {
  final String label;
  final double grams;
  final String iconPath;
  final Color iconBgColor;

  const MacroCard({
    super.key,
    required this.label,
    required this.grams,
    required this.iconPath,
    required this.iconBgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: iconBgColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: iconBgColor.withValues(alpha: 0.1))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: iconBgColor,
                border: Border.all(color: iconBgColor.withValues(alpha: 0.5), width: 2),
              ),
              child: Center(
                child: Image.asset(
                  iconPath,
                  height: 20,
                  width: 20,
                  fit: BoxFit.contain,
                  color: AppColors.white,
                ),
              ),
            ),
            Text(
              "${grams.toStringAsFixed(0)}g",
              style: AppTextStyle.h4,
            ),
            4.height,
            Text(
              label,
              style: AppTextStyle.body2,
            ),
          ],
        ),
      ),
    );
  }
}
