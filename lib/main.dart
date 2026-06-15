import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/constants/hive_boxes.dart';
import 'core/theme/app_theme.dart';
import 'data/services/hive_service.dart';
import 'presentation/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveService.init();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box(HiveBoxes.settings).listenable(),
      builder: (context, box, _) {
        final bool isDarkMode = box.get('isDarkMode', defaultValue: false);

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Study Planner',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: const SplashScreen(),
        );
      },
    );
  }
}
