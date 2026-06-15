import 'package:flutter/material.dart';

import '../../data/repositories/subject_repository.dart';
import '../../widgets/delete_dialog.dart';
import 'widgets/subject_card.dart';
import 'add_subject_page.dart';

class SubjectsPage extends StatefulWidget {
  const SubjectsPage({super.key});

  @override
  State<SubjectsPage> createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  final SubjectRepository repository = SubjectRepository();
  List subjects = [];

  @override
  void initState() {
    super.initState();
    loadSubjects();
  }

  void loadSubjects() {
    setState(() {
      subjects = repository.getSubjects();
    });
  }

  Future<void> _deleteSubject(int index) async {
    bool confirm = await DeleteDialog.show(
      context,
      title: "Delete Subject",
      content: "Are you sure you want to delete this subject?",
    );

    if (confirm) {
      await repository.deleteSubject(index);
      loadSubjects();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Subject Deleted")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Subjects"),
      ),
      body: subjects.isEmpty
          ? const Center(
              child: Text(
                "No Subjects Added Yet",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(subjects[index].toString() + index.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(Icons.delete, color: Colors.white, size: 30),
                  ),
                  confirmDismiss: (direction) async {
                    _deleteSubject(index);
                    return false;
                  },
                  child: SubjectCard(
                    subjectName: subjects[index]["name"].toString(),
                    targetHours: subjects[index]["targetHours"],
                    onDelete: () => _deleteSubject(index),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddSubjectPage(),
            ),
          );
          loadSubjects();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
