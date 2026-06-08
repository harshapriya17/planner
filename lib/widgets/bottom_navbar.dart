import 'package:flutter/material.dart';

import '../screens/home.dart';
import '../screens/subjects.dart';
import '../screens/tasks.dart';
import '../screens/sessions.dart';
import '../screens/profile.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() =>
      _BottomNavbarState();
}

class _BottomNavbarState
    extends State<BottomNavbar> {

  int currentIndex = 0;

  final List pages = [

    const HomePage(),
    const SubjectsPage(),
    const TasksPage(),
    const SessionsPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xffFFFDFB),
        selectedItemColor: const Color(0xffF79B63),
        unselectedItemColor: Colors.grey.shade500,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded, size: 28),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_rounded, size: 28),
            label: "Subjects",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt_rounded, size: 28),
            label: "Tasks",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer_rounded, size: 28),
            label: "Sessions",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded, size: 28),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}