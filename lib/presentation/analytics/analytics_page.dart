import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../core/constants/hive_boxes.dart';
import 'widgets/subject_bar_chart.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Analytics"),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box(HiveBoxes.tasks).listenable(),
        builder: (context, Box tasksBox, _) {
          final sessionsBox = Hive.box(HiveBoxes.sessions);

          final completedTasks = tasksBox.values.where((task) => task['completed'] == true).length;
          final totalSessions = sessionsBox.length;

          // Prepare data for the bar chart: Tasks per Subject
          Map<String, int> subjectTaskCount = {};
          for (var task in tasksBox.values) {
            String subject = task['subject'] ?? 'Unknown';
            subjectTaskCount[subject] = (subjectTaskCount[subject] ?? 0) + 1;
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Performance Summary",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                
                // Display the Bar Chart
                SubjectBarChart(data: subjectTaskCount),
                
                const SizedBox(height: 30),
                
                const Text(
                  "Quick Stats",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.withOpacity(0.1),
                      child: const Icon(Icons.timer, color: Colors.blue),
                    ),
                    title: const Text("Total Study Sessions"),
                    trailing: Text(
                      totalSessions.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.green.withOpacity(0.1),
                      child: const Icon(Icons.task_alt, color: Colors.green),
                    ),
                    title: const Text("Completed Tasks"),
                    trailing: Text(
                      completedTasks.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.orange.withOpacity(0.1),
                      child: const Icon(Icons.local_fire_department, color: Colors.orange),
                    ),
                    title: const Text("Current Streak"),
                    trailing: const Text(
                      "7",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
