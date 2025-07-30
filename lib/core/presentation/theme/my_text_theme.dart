import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors/colors.dart';

class MyTextTheme {
  static const _color1d = Color(0xff1d1d1d);
  static final lightTextTheme = TextTheme(
      displayLarge: GoogleFonts.dmSans(
          color: textColorLight, fontSize: 16, fontWeight: FontWeight.w700),
      displayMedium: GoogleFonts.dmSans(
          color: textColorLight, fontSize: 16, fontWeight: FontWeight.w500),
      displaySmall: GoogleFonts.dmSans(
          color: textColorLight, fontSize: 14, fontWeight: FontWeight.normal),
      bodySmall: GoogleFonts.dmSans(color: textColorLight, fontSize: 14),
      bodyMedium: GoogleFonts.dmSans(
          color: textColorLight, fontSize: 14, fontWeight: FontWeight.w500),
      bodyLarge: GoogleFonts.dmSans(
          color: textColorLight, fontSize: 14, fontWeight: FontWeight.w700),
      titleLarge: GoogleFonts.dmSans(
          color: _color1d, fontSize: 24, fontWeight: FontWeight.w700),
      titleMedium: GoogleFonts.dmSans(
          color: _color1d, fontSize: 16, fontWeight: FontWeight.w700),
      titleSmall: GoogleFonts.dmSans(
          color: _color1d, fontSize: 14, fontWeight: FontWeight.w300),
      labelLarge: GoogleFonts.dmSans(
          color: _color1d, fontSize: 16, fontWeight: FontWeight.w700),
      labelMedium: GoogleFonts.dmSans(
          color: textColorLight, fontSize: 16, fontWeight: FontWeight.w500));

  static final darkTextTheme = TextTheme(
      displayLarge:
          GoogleFonts.dmSans(color: textColorDark, fontWeight: FontWeight.w700),
      displayMedium: GoogleFonts.dmSans(
          color: textColorDark, fontSize: 16, fontWeight: FontWeight.w500),
      displaySmall: GoogleFonts.dmSans(
          color: textColorDark, fontSize: 14, fontWeight: FontWeight.normal),
      bodySmall: GoogleFonts.dmSans(
        color: textColorDark,
        fontSize: 14,
      ),
      bodyMedium: GoogleFonts.dmSans(
          color: textColorDark, fontSize: 14, fontWeight: FontWeight.w500),
      bodyLarge: GoogleFonts.dmSans(
          color: textColorDark, fontSize: 14, fontWeight: FontWeight.w700),
      titleLarge: GoogleFonts.dmSans(
          color: textColorDark, fontSize: 24, fontWeight: FontWeight.w700),
      titleMedium: GoogleFonts.dmSans(
          color: textColorDark, fontSize: 18, fontWeight: FontWeight.w500),
      titleSmall: GoogleFonts.dmSans(
          color: textColorDark, fontSize: 14, fontWeight: FontWeight.w300),
      labelLarge: GoogleFonts.dmSans(
          color: textColorDark, fontSize: 16, fontWeight: FontWeight.w700),
      labelMedium: GoogleFonts.dmSans(
          color: textColorDark, fontSize: 16, fontWeight: FontWeight.w500));
}
