import 'package:fitelo_app_assignment/utils/app_strings.dart';
import 'package:get/get.dart';
import '../services/storage_service.dart';

enum PaceType { gentle, recommended, intense, custom }

class PaceController extends GetxController {
  var selectedPace = PaceType.recommended.obs;
  var months = StorageService.getPaceMonths().obs;

  final paceMap = {
    PaceType.gentle: 6.0,
    PaceType.recommended: 3.0,
    PaceType.intense: 1.5,
  };

  void selectPace(PaceType pace) {
    selectedPace.value = pace;
    months.value = paceMap[pace]!;
    StorageService.savePaceMonths(months.value);
  }

  void updateMonths(double val) {
    months.value = val;
    StorageService.savePaceMonths(val);

    if ((val - 6.0).abs() <= 1.0) {
      selectedPace.value = PaceType.gentle;
    } else if ((val - 3.0).abs() <= 1.0) {
      selectedPace.value = PaceType.recommended;
    } else if ((val - 1.5).abs() <= 0.5) {
      selectedPace.value = PaceType.intense;
    } else {
      selectedPace.value = PaceType.custom;
    }
  }

  String get paceCaption {
    switch (selectedPace.value) {
      case PaceType.gentle:
        return AppStrings.gentleCaption;
      case PaceType.recommended:
        return AppStrings.recommendedCaption;
      case PaceType.intense:
        return AppStrings.intenseCaption;
      default:
        return AppStrings.customCaption;
    }
  }
}
