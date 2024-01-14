import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'color_values.dart';

class AppThemeData {
  static ThemeData getTheme(BuildContext context) {
    const Color primaryColor = ColorValues.primary50;
    final Map<int, Color> primaryColorMap = {
      50: primaryColor,
      100: primaryColor,
      200: primaryColor,
      300: primaryColor,
      400: primaryColor,
      500: primaryColor,
      600: primaryColor,
      700: primaryColor,
      800: primaryColor,
      900: primaryColor,
    };
    final MaterialColor primaryMaterialColor =
        MaterialColor(primaryColor.value, primaryColorMap);

    return ThemeData(
        primaryColor: primaryColor,
        primarySwatch: primaryMaterialColor,
        scaffoldBackgroundColor: ColorValues.background,
        canvasColor: ColorValues.background,
        brightness: Brightness.light,
        textTheme: TextTheme(
          titleLarge: GoogleFonts.sora(
              color: ColorValues.text90, fontSize: 18, fontWeight: FontWeight.w700),
          titleMedium: GoogleFonts.sora(
              color: ColorValues.text90, fontSize: 17, fontWeight: FontWeight.w700),
          titleSmall: GoogleFonts.sora(
              color: ColorValues.text90, fontSize: 14, fontWeight: FontWeight.w700),
          bodyLarge: GoogleFonts.sora(
              color: ColorValues.text90, fontSize: 18, fontWeight: FontWeight.w400),
          bodyMedium: GoogleFonts.sora(
              color: ColorValues.text90, fontSize: 14, fontWeight: FontWeight.w400),
          bodySmall: GoogleFonts.sora(
              color: ColorValues.text90, fontSize: 12, fontWeight: FontWeight.w400),
          labelLarge: GoogleFonts.sora(
              color: ColorValues.text90, fontSize: 14, fontWeight: FontWeight.w700),
          labelSmall: GoogleFonts.sora(
              color: ColorValues.text90, fontSize: 12, fontWeight: FontWeight.w700),
        ));
  }
}
