import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/splash.dart';

void main() {

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: "Study Planner",

      theme: ThemeData(

        /// FONT
        textTheme:
        GoogleFonts.poppinsTextTheme(),

        /// BACKGROUND
        scaffoldBackgroundColor:
        const Color(0xffF7EDE8),

        /// PRIMARY COLOR
        primaryColor:
        const Color(0xffB8A9FF),

        /// APPBAR
        appBarTheme: const AppBarTheme(

          backgroundColor:
          Color(0xffF7EDE8),

          foregroundColor:
          Colors.black,

          elevation: 0,

          centerTitle: true,
        ),

        /// CARD STYLE
          cardTheme: CardThemeData(

            color: const Color(0xffFFFDFB),

            elevation: 2,

            shape: RoundedRectangleBorder(

              borderRadius:
              BorderRadius.circular(25),
            ),
          ),

        /// BUTTON STYLE
        elevatedButtonTheme:
        ElevatedButtonThemeData(

          style: ElevatedButton.styleFrom(

            backgroundColor:
            const Color(0xffF79B63),

            foregroundColor:
            Colors.white,

            shape: RoundedRectangleBorder(

              borderRadius:
              BorderRadius.circular(18),
            ),

            padding:
            const EdgeInsets.symmetric(

              horizontal: 25,
              vertical: 15,
            ),
          ),
        ),
      ),

      home: const SplashScreen(),
    );
  }
}