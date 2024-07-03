import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextTheme {
  AppTextTheme._();

  static TextTheme textTheme = TextTheme(
    // Title Themes
    titleLarge: GoogleFonts.poppins(
      textStyle: const TextStyle().copyWith(
          fontSize: 36, fontWeight: FontWeight.w900, color: Colors.white),
    ),
    titleMedium: GoogleFonts.poppins(
      textStyle: const TextStyle().copyWith(
          fontSize: 30, fontWeight: FontWeight.w900, color: Colors.white),
    ),
    titleSmall: GoogleFonts.poppins(
      textStyle: const TextStyle().copyWith(
          fontSize: 26, fontWeight: FontWeight.w900, color: Colors.white),
    ),

    // Heading Themes
    headlineLarge: GoogleFonts.heebo(
      textStyle: const TextStyle().copyWith(
          fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white),
    ),
    headlineMedium: GoogleFonts.heebo(
      textStyle: const TextStyle().copyWith(
          fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white),
    ),
    headlineSmall: GoogleFonts.heebo(
      textStyle: const TextStyle().copyWith(
          fontSize: 20, fontWeight: FontWeight.w900, color: Colors.white),
    ),

    // Body Themes
    bodyLarge: GoogleFonts.sintony(
      textStyle: const TextStyle().copyWith(
          fontSize: 18, fontWeight: FontWeight.normal, color: Colors.white),
    ),
    bodyMedium: GoogleFonts.sintony(
      textStyle: const TextStyle().copyWith(
          fontSize: 16, fontWeight: FontWeight.normal, color: Colors.white),
    ),
    bodySmall: GoogleFonts.sintony(
      textStyle: const TextStyle().copyWith(
          fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white),
    ),
  );
}
