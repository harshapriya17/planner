import 'package:hive/hive.dart';

import '../../core/constants/hive_boxes.dart';

class SessionRepository {

  final Box box =
  Hive.box(HiveBoxes.sessions);

  List getSchedules() {

    return box.values.toList();
  }

  Future<void> addSchedule(
      Map<String, dynamic> schedule) async {

    await box.add(schedule);
  }

  Future<void> deleteSchedule(
      int index) async {

    await box.deleteAt(index);
  }
}