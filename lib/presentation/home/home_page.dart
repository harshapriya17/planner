import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../core/constants/hive_boxes.dart';
import '../../core/utils/greting_helper.dart';
import 'widgets/dashboard_card.dart';
import 'widgets/progress_card.dart';
import '../settings/settings_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Study Planner"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsPage()),
              );
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ValueListenableBuilder(
              valueListenable: Hive.box(HiveBoxes.settings).listenable(),
              builder: (context, Box settings, _) {
                final name = settings.get('userName', defaultValue: "");
                final String? imagePath = settings.get('profileImage');
                
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "${GreetingHelper.getGreeting()}\n${name.isNotEmpty ? name : 'Student'}",
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const SettingsPage()),
                        );
                      },
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.blue.withOpacity(0.1),
                        backgroundImage: imagePath != null ? FileImage(File(imagePath)) : null,
                        child: imagePath == null
                            ? const Icon(Icons.person, size: 40, color: Colors.blue)
                            : null,
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 5),
            const Text("Stay focused and achieve your goals!"),
            const SizedBox(height: 25),

            /// Progress Card (Daily Study Goal)
            const ProgressCard(
              completedHours: 3.2,
              targetHours: 5,
            ),
            const SizedBox(height: 30),

            const Text(
              "Analytics Overview",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),

            /// Analytics Section with Circular Cards
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                child: ValueListenableBuilder(
                  valueListenable: Hive.box(HiveBoxes.subjects).listenable(),
                  builder: (context, Box box, _) {
                    return ValueListenableBuilder(
                      valueListenable: Hive.box(HiveBoxes.tasks).listenable(),
                      builder: (context, Box tasksBox, _) {
                        return ValueListenableBuilder(
                          valueListenable: Hive.box(HiveBoxes.sessions).listenable(),
                          builder: (context, Box sessionsBox, _) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                DashboardCard(
                                  title: "Subjects",
                                  value: box.length.toString(),
                                  icon: Icons.book,
                                  color: Colors.orange,
                                ),
                                DashboardCard(
                                  title: "Tasks",
                                  value: tasksBox.length.toString(),
                                  icon: Icons.task,
                                  color: Colors.red,
                                ),
                                DashboardCard(
                                  title: "Schedules",
                                  value: sessionsBox.length.toString(),
                                  icon: Icons.schedule,
                                  color: Colors.blue,
                                ),
                                const DashboardCard(
                                  title: "Streak",
                                  value: "7",
                                  icon: Icons.local_fire_department,
                                  color: Colors.deepOrange,
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// Motivational Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.deepPurple, Colors.indigo],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Column(
                children: [
                  Icon(Icons.emoji_events, color: Colors.white, size: 50),
                  SizedBox(height: 10),
                  Text(
                    "Great Job!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "You are getting closer to your goals every day.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
