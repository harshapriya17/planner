class Task {

  int? id;

  String title;

  int subjectId;

  DateTime deadline;

  bool completed;

  Task({

    this.id,

    required this.title,

    required this.subjectId,

    required this.deadline,

    required this.completed,
  });
}