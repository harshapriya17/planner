import 'package:hive/hive.dart';

import '../../core/constants/hive_boxes.dart';

class SubjectRepository {

  final Box box =
  Hive.box(HiveBoxes.subjects);

  List getSubjects() {

    return box.values.toList();
  }

  Future<void> addSubject(
      Map<String, dynamic> subject) async {

    await box.add(subject);
  }

  Future<void> deleteSubject(
      int index) async {

    await box.deleteAt(index);
  }

  Future<void> updateSubject(

      int index,

      Map<String, dynamic> subject) async {

    await box.putAt(
      index,
      subject,
    );
  }
}