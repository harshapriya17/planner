import 'dart:async';

import 'package:flutter/material.dart';

import '../widgets/bottom_navbar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState
    extends State<SplashScreen> {

  @override
  void initState() {

    super.initState();

    Timer(

      const Duration(seconds: 3),
          () {

        Navigator.pushReplacement(

          context,

          MaterialPageRoute(

            builder: (context) =>
            const BottomNavbar(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,

      body: Center(

        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [

            Container(

              height: 120,
              width: 120,

              decoration: BoxDecoration(

                color: Colors.blue.shade50,

                borderRadius:
                BorderRadius.circular(25),
              ),

              child: const Icon(

                Icons.school,

                size: 70,

                color: Colors.blue,
              ),
            ),

            const SizedBox(height: 25),

            const Text(

              "Study Planner",

              style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                letterSpacing: 2,
              ),
            ),

            const SizedBox(height: 10),

            Text(

              "Calm • Focus • Start",

              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}