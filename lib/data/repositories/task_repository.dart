import 'package:hive/hive.dart';

import '../../core/constants/hive_boxes.dart';

class TaskRepository {

  final Box box =
  Hive.box(HiveBoxes.tasks);

  List getTasks() {

    return box.values.toList();
  }

  Future<void> addTask(
      Map<String, dynamic> task) async {

    await box.add(task);
  }

  Future<void> deleteTask(
      int index) async {

    await box.deleteAt(index);
  }

  Future<void> updateTask(

      int index,

      Map<String, dynamic> task) async {

    await box.putAt(
      index,
      task,
    );
  }
}