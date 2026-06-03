import 'package:flutter/material.dart';
import 'package:planner/models/subject_model.dart';

import 'package:planner/screens/home.dart';
import 'package:planner/screens/subjects.dart';
import 'package:planner/screens/tasks.dart';
import 'package:planner/screens/sessions.dart';
import 'package:planner/screens/profile.dart';

class BottomNavbar extends StatefulWidget{
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState()=>
      _BottomNavState();
}
class _BottomNavbarState
extends State<BottomNavbar>{

  int currentIndex=0;

  final List pages=[
    const HomePage(),
    const SubjectsPage(),
    const TasksPage(),
    const SessionsPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBar.fixed,

      ),
    )
  }
}