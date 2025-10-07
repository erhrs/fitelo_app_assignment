import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyle {

  // Headings
  static final TextStyle h1 = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle h2 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle h3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle h4 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  // Body Text
  static final TextStyle body1 = TextStyle(
    fontSize: 16,
  );

  static final TextStyle body2 = TextStyle(
    fontSize: 14,
  );

  static final TextStyle body3 = TextStyle(
    fontSize: 12,
  );

  // ====== Color Variants ======

  // h1
  static final TextStyle h1WhiteColor = h1.copyWith(color: AppColors.white);
  static final TextStyle h1PrimaryColor = h1.copyWith(color: AppColors.primaryColor);
  static final TextStyle h1BlackColor = h1.copyWith(color: AppColors.black);

  // h2
  static final TextStyle h2WhiteColor = h2.copyWith(color: AppColors.white);
  static final TextStyle h2PrimaryColor = h2.copyWith(color: AppColors.primaryColor);
  static final TextStyle h2BlackColor = h2.copyWith(color: AppColors.black);

  // h3
  static final TextStyle h3WhiteColor = h3.copyWith(color: AppColors.white);
  static final TextStyle h3PrimaryColor = h3.copyWith(color: AppColors.primaryColor);
  static final TextStyle h3BlackColor = h3.copyWith(color: AppColors.black);

  // h4
  static final TextStyle h4WhiteColor = h4.copyWith(color: AppColors.white);
  static final TextStyle h4PrimaryColor = h4.copyWith(color: AppColors.primaryColor);
  static final TextStyle h4BlackColor = h4.copyWith(color: AppColors.black);

  // body1
  static final TextStyle body1WhiteColor = body1.copyWith(color: AppColors.white);
  static final TextStyle body1PrimaryColor = body1.copyWith(color: AppColors.primaryColor);
  static final TextStyle body1BlackColor = body1.copyWith(color: AppColors.black);

  // body2
  static final TextStyle body2WhiteColor = body2.copyWith(color: AppColors.white);
  static final TextStyle body2PrimaryColor = body2.copyWith(color: AppColors.primaryColor);
  static final TextStyle body2BlackColor = body2.copyWith(color: AppColors.black);

  // body3
  static final TextStyle body3WhiteColor = body3.copyWith(color: AppColors.white);
  static final TextStyle body3PrimaryColor = body3.copyWith(color: AppColors.primaryColor);
  static final TextStyle body3BlackColor = body3.copyWith(color: AppColors.black);
}
