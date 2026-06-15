import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../widgets/bottom_navbar.dart';

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

      const Duration(seconds: 2),

          () {

        Navigator.pushReplacement(

          context,

          MaterialPageRoute(

            builder: (_) =>
            const BottomNavbar(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      AppColors.background,

      body: Center(

        child: Column(

          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [

            /// LOGO
            Container(

              height: 120,

              width: 120,

              decoration: BoxDecoration(

                color:
                AppColors.primary,

                borderRadius:
                BorderRadius.circular(30),
              ),

              child: const Icon(

                Icons.school_rounded,

                size: 70,

                color: Colors.white,
              ),
            ),

            const SizedBox(height: 25),

            /// APP NAME
            const Text(

              "Study Planner",

              style: TextStyle(

                fontSize: 32,

                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(

              "Plan • Study • Achieve",

              style: TextStyle(

                fontSize: 16,

                color:
                AppColors.textLight,
              ),
            ),

            const SizedBox(height: 40),

            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}