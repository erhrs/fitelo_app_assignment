import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'goal_screen.dart';
import 'pace_screen.dart';
import 'calorie_screen.dart';
import '../utils/app_colors.dart';
import '../utils/extensions.dart';
import '../utils/common_widgets.dart';


class GoalFlowScreen extends StatefulWidget {
  const GoalFlowScreen({super.key});

  @override
  State<GoalFlowScreen> createState() => _GoalFlowScreenState();
}

class _GoalFlowScreenState extends State<GoalFlowScreen> {
  final RxInt currentPage = 0.obs;
  final int totalPages = 3;

  void _nextPage() {
    if (currentPage.value < totalPages - 1) {
      currentPage.value++;
    }
  }

  void _previousPage() {
    if (currentPage.value > 0) {
      currentPage.value--;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            30.height,
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(totalPages, (i) {
                final isActive = i == currentPage.value;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: isActive ? 30 : 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppColors.primaryColor
                        : AppColors.grey.withValues(alpha: 0.45),
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              }),
            )),
            20.height,
            Expanded(
              child: Obx(() {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(
                        scale: Tween<double>(begin: 0.95, end: 1.0).animate(
                          CurvedAnimation(parent: animation, curve: Curves.easeOut),
                        ),
                        child: child,
                      ),
                    );
                  },
                  child: _buildPage(currentPage.value),
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: bottomButtons(
                onBackPressed: _previousPage,
                onContinuePressed: _nextPage,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const GoalScreen(key: ValueKey('goal'));
      case 1:
        return const PaceScreen(key: ValueKey('pace'));
      case 2:
        return const CalorieScreen(key: ValueKey('calorie'));
      default:
        return const SizedBox();
    }
  }

}

