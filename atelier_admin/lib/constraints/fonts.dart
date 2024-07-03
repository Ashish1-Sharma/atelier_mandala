import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static final TextStyle h1 = GoogleFonts.poppins(
    fontSize: 28,
    height: 1.1,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle h2 = GoogleFonts.poppins(
    fontSize: 24,
    height: 1.2,
    fontWeight: FontWeight.normal,
  );

  static final TextStyle h3 = GoogleFonts.poppins(
    fontSize: 20,
    height: 1.2,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle h4 = GoogleFonts.poppins(
    fontSize: 18,
    height: 1.2,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle bodyBig = GoogleFonts.poppins(
    fontSize: 18,
    height: 1.3,
    letterSpacing: 0,
    fontWeight: FontWeight.normal,
  );

  static final TextStyle bodyMain18 = GoogleFonts.poppins(
    fontSize: 18,
    height: 1.3,
    fontWeight: FontWeight.normal,
  );

  static final TextStyle bodyMain16 = GoogleFonts.poppins(
    fontSize: 16,
    height: 1.3,
    fontWeight: FontWeight.normal,
  );

  static final TextStyle bodySmall = GoogleFonts.poppins(
    fontSize: 14,
    height: 1.3,
    fontWeight: FontWeight.normal,
  );

  static final TextStyle bodySmallest = GoogleFonts.poppins(
    fontSize: 12,
    height: 1.3,
    fontWeight: FontWeight.normal,
  );
}

class AppShades {
  // Red Shades
  static const Color red50 = Color(0xFFFFF1F1);
  static const Color red75 = Color(0xFFFCEFC5);
  static const Color red100 = Color(0xFFFECBAD);
  static const Color red200 = Color(0xFFFDF8E9);
  static const Color red300 = Color(0xFFFDBB71);
  static const Color red400 = Color(0xFFB1614F);
  static const Color red500 = Color(0xFFA85A45);

  // Blue Shades
  static const Color blue50 = Color(0xFFE8E9EC);
  static const Color blue100 = Color(0xFFB8B9C3);
  static const Color blue200 = Color(0xFF9598A6);
  static const Color blue300 = Color(0xFF65687E);
  static const Color blue400 = Color(0xFF474B65);
  static const Color blue500 = Color(0xFF1B1E3E);
  static const Color blue600 = Color(0xFF171B36);
  static const Color blue700 = Color(0xFF12152E);
  static const Color blue800 = Color(0xFF0E1122);
  static const Color blue900 = Color(0xFF0B0D1A);
}
