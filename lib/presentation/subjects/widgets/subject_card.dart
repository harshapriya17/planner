import 'package:flutter/material.dart';

class SubjectCard extends StatelessWidget {
  final String subjectName;
  final int targetHours;
  final VoidCallback? onDelete;

  const SubjectCard({
    super.key,
    required this.subjectName,
    required this.targetHours,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.book),
        title: Text(subjectName),
        subtitle: Text("Target: $targetHours hrs/week"),
        trailing: onDelete != null
            ? IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: onDelete,
              )
            : null,
      ),
    );
  }
}