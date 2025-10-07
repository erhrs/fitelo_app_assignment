import 'package:get/get.dart';
import '../services/storage_service.dart';

class CalorieController extends GetxController {
  final maintenanceCalories = 2200.0.obs;
  final dailyCalories = 0.0.obs;
  final carbs = 0.0.obs;
  final protein = 0.0.obs;
  final fat = 0.0.obs;

  void calculateCalories() {
    final goalKg = StorageService.getGoal();
    final months = StorageService.getPaceMonths();

    double totalDeficit = goalKg * 7700;
    double days = months * 30.4;
    double dailyDeficit = days > 0 ? totalDeficit / days : 0;

    double result = maintenanceCalories.value - dailyDeficit;
    if (goalKg == 0) result = maintenanceCalories.value;
    if (result < 1200) result = 1200;

    dailyCalories.value = result.floorToDouble();

    carbs.value = ((result * 0.45) / 4).roundToDouble();
    protein.value = ((result * 0.30) / 4).roundToDouble();
    fat.value = ((result * 0.25) / 9).roundToDouble();
  }

  void updateMaintenance(double val) {
    maintenanceCalories.value = val;
    calculateCalories();
  }
}
