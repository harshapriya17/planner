import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const background = Color(0xffF7EDE8);
  static const card = Color(0xffFFFDFB);
  static const primary = Color(0xffB8A9FF);
  static const secondary = Color(0xffF79B63);

  static const textDark = Color(0xff1F1F1F);
  static const textLight = Color(0xff8B8B8B);

  // Dark mode colors
  static const darkBackground = Color(0xff121212);
  static const darkCard = Color(0xff1E1E1E);
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    textTheme: GoogleFonts.poppinsTextTheme(),
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primary,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      foregroundColor: Colors.black,
      centerTitle: true,
      elevation: 0,
    ),
    cardTheme: const CardThemeData(
      color: AppColors.card,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
    scaffoldBackgroundColor: AppColors.darkBackground,
    primaryColor: AppColors.primary,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      brightness: Brightness.dark,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkBackground,
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
    ),
    cardTheme: const CardThemeData(
      color: AppColors.darkCard,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
    ),
  );
}
