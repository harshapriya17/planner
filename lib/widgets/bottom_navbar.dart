import 'package:flutter/material.dart';

import '../presentation/analytics/analytics_page.dart';
import '../presentation/home/home_page.dart';
import '../presentation/subjects/subjects_page.dart';
import '../presentation/tasks/tasks_page.dart';
import '../presentation/timetable/timetable_page.dart';

import '../core/constants/app_colors.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const HomePage(),
    const SubjectsPage(),
    const TasksPage(),
    const TimetablePage(),
    const AnalyticsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.card,
        selectedItemColor: AppColors.secondary,
        unselectedItemColor: AppColors.textLight,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_rounded),
            label: "Subjects",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt_rounded),
            label: "Tasks",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule_rounded),
            label: "Timetable",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_rounded),
            label: "Analytics",
          ),
        ],
      ),
    );
  }
}
