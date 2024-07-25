import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
double getResponsiveFontSize(double baseFontSize) {
  return baseFontSize * Get.width / 375; // Assuming 375 is the base width of your design
}

class AppTextStyles {
  static TextStyle h1({Color color = Colors.black}) => GoogleFonts.poppins(
    fontSize: getResponsiveFontSize(28),
    height: 1.1,
    fontWeight: FontWeight.w700,
    color: color,
  );
  static TextStyle h1withnormal({Color color = Colors.black}) => GoogleFonts.poppins(
    fontSize: getResponsiveFontSize(24),
    height: 1.2,
    fontWeight: FontWeight.w500,
    color: color,
  );

  static TextStyle h2({Color color = Colors.black}) => GoogleFonts.poppins(
    fontSize: getResponsiveFontSize(22),
    height: 1.2,
    fontWeight: FontWeight.w700,
    color: color,
  );
  static TextStyle h2Normal({Color color = Colors.black}) => GoogleFonts.poppins(
    fontSize: getResponsiveFontSize(22),
    height: 1.2,
    fontWeight: FontWeight.w500,
    color: color,
  );

  static TextStyle h3({Color color = Colors.black}) => GoogleFonts.poppins(
    fontSize: getResponsiveFontSize(20),
    height: 1.2,
    fontWeight: FontWeight.bold,
    color: color,
  );
  static TextStyle h3Normal({Color color = Colors.black}) => GoogleFonts.poppins(
    fontSize: getResponsiveFontSize(20),
    height: 1.2,
    fontWeight: FontWeight.w600,
    color: color,
  );
  static TextStyle h3MoreNormal({Color color = Colors.black}) => GoogleFonts.poppins(
    fontSize: getResponsiveFontSize(20),
    height: 1.2,
    fontWeight: FontWeight.w400,
    color: color,
  );

  static TextStyle h4({Color color = Colors.black}) => GoogleFonts.poppins(
    fontSize: getResponsiveFontSize(18),
    height: 1.2,
    fontWeight: FontWeight.bold,
    color: color,
  );

  static TextStyle bodyBig({Color color = Colors.black}) => GoogleFonts.poppins(
    fontSize: getResponsiveFontSize(18),
    height: 1.3,
    letterSpacing: 0,
    fontWeight: FontWeight.w600,
    color: color,
  );
  static TextStyle bodyBigNormal({Color color = Colors.black}) => GoogleFonts.poppins(
    fontSize: getResponsiveFontSize(18),
    height: 1.3,
    letterSpacing: 0,
    fontWeight: FontWeight.w400,
    color: color,
  );

  static TextStyle bodyMain18({Color color = Colors.black}) => GoogleFonts.poppins(
    fontSize: getResponsiveFontSize(18),
    height: 1.3,
    fontWeight: FontWeight.normal,
    color: color,
  );

  static TextStyle bodyMain16({Color color = Colors.black}) => GoogleFonts.poppins(
    fontSize: getResponsiveFontSize(16),
    height: 1.3,
    fontWeight: FontWeight.normal,
    color: color,
  );
  static TextStyle bodyMain16withBold({Color color = Colors.black}) => GoogleFonts.poppins(
    fontSize: getResponsiveFontSize(16),
    height: 1.3,
    fontWeight: FontWeight.bold,
    color: color,
  );
  static TextStyle bodyMain14({Color color = Colors.black}) => GoogleFonts.poppins(
    fontSize: getResponsiveFontSize(16),
    height: 1.3,
    fontWeight: FontWeight.w700,
    color: color,
  );

  static TextStyle bodySmall({Color color = Colors.black}) => GoogleFonts.poppins(
    fontSize: getResponsiveFontSize(14),
    height: 1.3,
    fontWeight: FontWeight.w600,
    color: color,
  );

  static TextStyle bodySmallwithNormal({Color color = Colors.black}) => GoogleFonts.poppins(
    fontSize: getResponsiveFontSize(14),
    height: 1.3,
    fontWeight: FontWeight.w400,
    color: color,
  );

  static TextStyle bodySmallest({Color color = Colors.black}) => GoogleFonts.poppins(
    fontSize: getResponsiveFontSize(12),
    height: 1.3,
    fontWeight: FontWeight.w400,
    color: color,
  );
  static TextStyle bodyMini({Color color = Colors.black}) => GoogleFonts.poppins(
    fontSize: getResponsiveFontSize(8),
    height: 1.3,
    fontWeight: FontWeight.w400,
    color: color,
  );
}

class AppShades {
  // Red Shades
  static const Color red50 = Color(0xFFFFF1F1);
  static const Color red75 = Color(0xFFFCEFC5);
  static const Color red100 = Color(0xFFFBDFD8);
  static const Color red150 = Color(0xFFFECBAD);
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

//   Black shades
  static const Color black200 = Color(0xFFF2F2F7);

}
