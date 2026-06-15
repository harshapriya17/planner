class StudySession {

  int? id;

  int subjectId;

  String day;

  String startTime;

  String endTime;

  StudySession({

    this.id,

    required this.subjectId,

    required this.day,

    required this.startTime,

    required this.endTime,
  });
}