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

      bottomNavigationBar: Container(

        margin: const EdgeInsets.all(12),

        decoration: BoxDecoration(

          color: const Color(0xffFFFDFB),

          borderRadius:
          BorderRadius.circular(30),

          boxShadow: [

            BoxShadow(

              color: Colors.grey.shade300,

              blurRadius: 10,

              offset: const Offset(0, 5),
            ),
          ],
        ),

        child: BottomNavigationBar(

          currentIndex: currentIndex,

          type: BottomNavigationBarType.fixed,

          backgroundColor: Colors.transparent,

          elevation: 0,

          selectedItemColor:
          const Color(0xffF79B63),

          unselectedItemColor:
          Colors.grey.shade500,

          showSelectedLabels: false,

          showUnselectedLabels: false,

          onTap: (index) {

            setState(() {

              currentIndex = index;

            });
          },

          items: [

            BottomNavigationBarItem(

              icon: navIcon(

                icon: Icons.home_rounded,

                index: 0,
              ),

              label: "",
            ),

            BottomNavigationBarItem(

              icon: navIcon(

                icon: Icons.menu_book_rounded,

                index: 1,
              ),

              label: "",
            ),

            BottomNavigationBarItem(

              icon: navIcon(

                icon: Icons.task_alt_rounded,

                index: 2,
              ),

              label: "",
            ),

            BottomNavigationBarItem(

              icon: navIcon(

                icon: Icons.timer_rounded,

                index: 3,
              ),

              label: "",
            ),

            BottomNavigationBarItem(

              icon: navIcon(

                icon: Icons.person_rounded,

                index: 4,
              ),

              label: "",
            ),
          ],
        ),
      ),
    );
  }

  /// CUSTOM NAV ICON
  Widget navIcon({

    required IconData icon,
    required int index,

  }) {

    bool isSelected =
        currentIndex == index;

    return AnimatedContainer(

      duration:
      const Duration(milliseconds: 250),

      padding: const EdgeInsets.all(10),

      decoration: BoxDecoration(

        color: isSelected
            ? const Color(0xffF79B63)
            : Colors.transparent,

        borderRadius:
        BorderRadius.circular(18),
      ),

      child: Icon(

        icon,

        size: 28,

        color: isSelected
            ? Colors.white
            : Colors.grey,
      ),
    );
  }
}