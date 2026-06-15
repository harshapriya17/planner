import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  final String title;
  final String content;

  const DeleteDialog({
    super.key,
    required this.title,
    required this.content,
  });

  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String content,
  }) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => DeleteDialog(title: title, content: content),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text(
            "No",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text(
            "Yes",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
