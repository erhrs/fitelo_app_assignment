import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static double getGoal() => _prefs.getDouble('goal') ?? 0.0;
  static Future<void> saveGoal(double value) async => _prefs.setDouble('goal', value);

  static double getPaceMonths() => _prefs.getDouble('pace_months') ?? 3.0;
  static Future<void> savePaceMonths(double value) async => _prefs.setDouble('pace_months', value);
}
