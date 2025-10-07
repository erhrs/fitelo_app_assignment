import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_routes.dart';
import 'services/storage_service.dart';
import 'views/goal_screen.dart';
import 'views/pace_screen.dart';
import 'views/calorie_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _initStorage();
  }

  Future<void> _initStorage() async {
    await StorageService.init();
    setState(() => _initialized = true);
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator(color: Colors.orange)),
        ),
      );
    }

    return GetMaterialApp(
      title: 'Goal → Pace → Calories',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.orange,
      ),
      initialRoute: Routes.goal,
      getPages: [
        GetPage(name: Routes.goal, page: () => const GoalScreen()),
        GetPage(name: Routes.pace, page: () => const PaceScreen()),
        GetPage(name: Routes.calorie, page: () => const CalorieScreen()),
      ],
    );
  }
}
