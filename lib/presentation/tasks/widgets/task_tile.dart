import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final String title;
  final bool completed;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  const TaskTile({
    super.key,
    required this.title,
    required this.completed,
    required this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Checkbox(
          value: completed,
          onChanged: (_) => onTap(),
        ),
        title: Text(
          title,
          style: TextStyle(
            decoration: completed ? TextDecoration.lineThrough : null,
          ),
        ),
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