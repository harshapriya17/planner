import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../data/repositories/task_repository.dart';
import '../../data/repositories/subject_repository.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final taskController = TextEditingController();
  final subjectController = TextEditingController();
  final TaskRepository repository = TaskRepository();
  final SubjectRepository subjectRepository = SubjectRepository();
  DateTime? selectedDate;

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
        title: const Text("Add Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomTextField(
              controller: taskController,
              hintText: "Task Title",
              icon: Icons.task,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: subjectController,
              hintText: "Subject",
              icon: Icons.book,
              readOnly: true,
              onTap: _showSubjectPicker,
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.calendar_month),
              title: Text(
                selectedDate == null
                    ? "Select Deadline"
                    : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2030),
                  initialDate: DateTime.now(),
                );
                if (picked != null) {
                  setState(() {
                    selectedDate = picked;
                  });
                }
              },
            ),
            const SizedBox(height: 30),
            CustomButton(
              text: "Save Task",
              onPressed: () async {
                if (taskController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please enter task title")),
                  );
                  return;
                }
                if (subjectController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please select a subject")),
                  );
                  return;
                }

                await repository.addTask({
                  "title": taskController.text.trim(),
                  "subject": subjectController.text.trim(),
                  "deadline": selectedDate?.toIso8601String(),
                  "completed": false,
                });

                if (!mounted) return;

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Task Saved Successfully")),
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
    taskController.dispose();
    subjectController.dispose();
    super.dispose();
  }
}
