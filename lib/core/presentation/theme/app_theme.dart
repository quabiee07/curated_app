import 'package:flutter/material.dart';
import 'package:curated_app/core/presentation/theme/colors/colors.dart';
import 'package:curated_app/core/presentation/theme/colors/snack_bar_colors.dart';
import 'package:curated_app/core/presentation/theme/my_text_theme.dart';
import 'package:google_fonts/google_fonts.dart';

mixin AppTheme {
  ThemeData lightTheme() {
    return ThemeData.from(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        surface: Color(0xffF8F8F8),
        onSurface: textColorLight,
        tertiary: textAccentLight,
        secondary: cardBackgorund,
      ),
    ).copyWith(
        scaffoldBackgroundColor: const Color(0xffF8F8F8),
        primaryColor: _buttonLightColor,
        splashFactory: NoSplash.splashFactory,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: _buttonLightColor,
          foregroundColor: Colors.white,
          elevation: 2,
        ),
        cardTheme: CardThemeData(
            color: cardBackgroundLight,
            surfaceTintColor: Colors.transparent,
            shadowColor: Colors.black,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: GoogleFonts.dmSans(
            color: grey,
            fontSize: 14,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          filled: true,
          fillColor: Colors.white,
          errorStyle: GoogleFonts.dmSans(
            color: errorForeground,
            fontSize: 14,
          ),
          border: _inputBorderLight,
          enabledBorder: _inputBorderLight,
          focusedBorder: _inputBorderLight,
          disabledBorder: _inputBorderLight,
          errorBorder: _inputBorderLight,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: purple,
            disabledBackgroundColor: purple.withValues(alpha: .5),
            minimumSize: const Size(double.infinity, double.infinity),
            foregroundColor: Colors.white,
            shadowColor: buttonColor.withValues(alpha: .05),
            textStyle: GoogleFonts.dmSans(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,),
            overlayColor: Colors.white,
            splashFactory: NoSplash.splashFactory,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
        textSelectionTheme: TextSelectionThemeData(
            cursorColor: textColorLight,
            selectionColor: textColorLight.withValues(alpha: .5),
            selectionHandleColor: textColorLight.withValues(alpha: .7)),
        textTheme: MyTextTheme.lightTextTheme);
  }

  ThemeData darkTheme() {
    return ThemeData.from(
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(
        surface: Color(0xff010101),
        onSurface: textColorDark,
        tertiary: textAccentDark,
        secondary: walletTopDark,
      ),
    ).copyWith(
        scaffoldBackgroundColor: const Color(0xff010101),
        primaryColor: _buttonDarkColor,
        splashFactory: NoSplash.splashFactory,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: _buttonDarkColor,
          foregroundColor: Colors.white,
          elevation: 2,
        ),
        cardTheme: CardThemeData(
            color: cardBackgroundDark,
            surfaceTintColor: Colors.transparent,
            shadowColor: Colors.white,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: const TextStyle(
            color: Color(0xFF959595),
            fontFamily: 'DMSans',
            fontSize: 14,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          filled: true,
          fillColor: cardBackgroundDark,
          errorStyle: const TextStyle(
            color: errorForeground,
            fontFamily: 'DMSans',
            fontSize: 14,
          ),
          border: _inputBorderDark,
          enabledBorder: _inputBorderDark,
          focusedBorder: _inputBorderDark,
          disabledBorder: _inputBorderDark,
          errorBorder: _inputBorderDark,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: purple,
            disabledBackgroundColor: Colors.grey,
            minimumSize: const Size(double.infinity, double.infinity),
            foregroundColor: Colors.white,
            shadowColor: buttonColor.withValues(alpha: .5),
            textStyle: const TextStyle(
                fontFamily: 'DMSans',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: textColorDark),
            splashFactory: NoSplash.splashFactory,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
        textSelectionTheme: TextSelectionThemeData(
            cursorColor: textColorDark,
            selectionColor: textColorDark.withValues(alpha: .5),
            selectionHandleColor: textColorDark.withValues(alpha: .7)),
        textTheme: MyTextTheme.darkTextTheme);
  }

  static const _buttonLightColor = Color(0xFF000000);
  static const _buttonDarkColor = Color(0xFFFFFFFF);

  static final _inputBorderLight = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(
      color: Color(0xFFE5E5E5),
    ),
  );
  static final _inputBorderDark = OutlineInputBorder(
    borderRadius: BorderRadius.circular(6),
    borderSide: BorderSide.none,
  );
}
