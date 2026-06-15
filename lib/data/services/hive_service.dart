import 'package:hive_flutter/hive_flutter.dart';

import '../../core/constants/hive_boxes.dart';

class HiveService {

  static Future<void> init() async {

    await Hive.initFlutter();

    await Hive.openBox(
      HiveBoxes.subjects,
    );

    await Hive.openBox(
      HiveBoxes.tasks,
    );

    await Hive.openBox(
      HiveBoxes.sessions,
    );

    await Hive.openBox(
      HiveBoxes.settings,
    );
  }
}