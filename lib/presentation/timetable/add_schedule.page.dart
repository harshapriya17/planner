import 'package:flutter/material.dart';
import '../../data/repositories/session_repository.dart';
import '../../data/repositories/subject_repository.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class AddSchedulePage extends StatefulWidget {
  const AddSchedulePage({super.key});

  @override
  State<AddSchedulePage> createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  final subjectController = TextEditingController();
  final topicController = TextEditingController();
  final SessionRepository repository = SessionRepository();
  final SubjectRepository subjectRepository = SubjectRepository();
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  void _showSubjectPicker() async {
    final subjects = subjectRepository.getSubjects();
    if (subjects.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No subjects found. Please add a subject first.")),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Select Subject"),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                final subject = subjects[index]['name'];
                return ListTile(
                  title: Text(subject),
                  onTap: () {
                    subjectController.text = subject;
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Schedule"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomTextField(
              controller: subjectController,
              hintText: "Subject",
              icon: Icons.book,
              readOnly: true,
              onTap: _showSubjectPicker,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: topicController,
              hintText: "Topic",
              icon: Icons.menu_book,
            ),
            const SizedBox(height: 20),
            ListTile(
              title: Text(
                startTime == null ? "Select Start Time" : startTime!.format(context),
              ),
              leading: const Icon(Icons.access_time),
              onTap: () async {
                TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (picked != null) {
                  setState(() {
                    startTime = picked;
                  });
                }
              },
            ),
            ListTile(
              title: Text(
                endTime == null ? "Select End Time" : endTime!.format(context),
              ),
              leading: const Icon(Icons.timer),
              onTap: () async {
                TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (picked != null) {
                  setState(() {
                    endTime = picked;
                  });
                }
              },
            ),
            const SizedBox(height: 30),
            CustomButton(
              text: "Save Schedule",
              onPressed: () async {
                if (subjectController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please select a subject")),
                  );
                  return;
                }
                if (startTime == null || endTime == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please select start and end time")),
                  );
                  return;
                }

                await repository.addSchedule({
                  "subject": subjectController.text.trim(),
                  "topic": topicController.text.trim(),
                  "time": "${startTime!.format(context)} - ${endTime!.format(context)}",
                  "startTime": "${startTime!.hour}:${startTime!.minute}",
                  "endTime": "${endTime!.hour}:${endTime!.minute}",
                });

                if (!mounted) return;

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Schedule Saved Successfully")),
                );

                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    subjectController.dispose();
    topicController.dispose();
    super.dispose();
  }
}
