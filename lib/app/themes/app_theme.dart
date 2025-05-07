import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    hintColor: AppColors.textSecondary,
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.background),
    cardColor: AppColors.secondary,
    iconTheme: const IconThemeData(color: AppColors.textSecondary),
    textTheme: GoogleFonts.figtreeTextTheme().copyWith(
      bodyLarge: GoogleFonts.figtree(fontSize: 16, color: Colors.black),
      labelMedium:
          GoogleFonts.figtree(fontSize: 14, color: AppColors.textPrimary),
      bodyMedium: GoogleFonts.figtree(fontSize: 14, color: Colors.grey),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primary,
    hintColor: Colors.white,
    scaffoldBackgroundColor: Colors.black,
    cardColor: const Color.fromARGB(255, 51, 51, 51),
    appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
    iconTheme: const IconThemeData(color: AppColors.secondary),
    textTheme: GoogleFonts.figtreeTextTheme().copyWith(
      bodyLarge: GoogleFonts.figtree(fontSize: 16, color: Colors.white),
      labelMedium: GoogleFonts.figtree(fontSize: 14, color: Colors.white),
      bodyMedium: GoogleFonts.figtree(fontSize: 14, color: Colors.grey),
    ),
  );
}
