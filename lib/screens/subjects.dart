import 'package:flutter/material.dart';

class SubjectsPage extends StatelessWidget {
  const SubjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Subjects"),
        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: const [
          SubjectCard(
            subject: "Physics",
            target: "8 hrs/week",
            icon: Icons.science,
            color: Colors.blue,
          ),

          SizedBox(height: 12),

          SubjectCard(
            subject: "Maths",
            target: "10 hrs/week",
            icon: Icons.calculate,
            color: Colors.green,
          ),

          SizedBox(height: 12),

          SubjectCard(
            subject: "Flutter",
            target: "12 hrs/week",
            icon: Icons.flutter_dash,
            color: Colors.cyan,
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Add Subject Clicked"),
            ),
          );
        },

        icon: const Icon(Icons.add),
        label: const Text("Add Subject"),
      ),
    );
  }
}

class SubjectCard extends StatelessWidget {
  final String subject;
  final String target;
  final IconData icon;
  final Color color;

  const SubjectCard({
    super.key,
    required this.subject,
    required this.target,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),

      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(
            icon,
            color: color,
          ),
        ),

        title: Text(
          subject,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Text(
          "Target: $target",
        ),

        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 18,
        ),
      ),
    );
  }
}