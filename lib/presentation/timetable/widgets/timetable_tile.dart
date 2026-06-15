import 'package:flutter/material.dart';

class TimetableTile extends StatelessWidget {
  final String subject;
  final String time;
  final VoidCallback? onDelete;

  const TimetableTile({
    super.key,
    required this.subject,
    required this.time,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.book),
        ),
        title: Text(subject),
        subtitle: Text(time),
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
