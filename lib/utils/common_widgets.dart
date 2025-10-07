import 'package:flutter/material.dart';
import 'app_colors.dart';

Widget dot(bool active) => Container(
  margin: const EdgeInsets.symmetric(horizontal: 4),
  width: 10,
  height: 10,
  decoration: BoxDecoration(
    color: active ? AppColors.primaryColor : Colors.grey.shade300,
    shape: BoxShape.circle,
  ),
);