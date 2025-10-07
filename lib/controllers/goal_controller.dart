import 'package:get/get.dart';
import '../services/storage_service.dart';

class GoalController extends GetxController {
  var goalKg = StorageService.getGoal().obs;

  void setGoal(double value) {
    goalKg.value = value;
    StorageService.saveGoal(value);
  }
}
