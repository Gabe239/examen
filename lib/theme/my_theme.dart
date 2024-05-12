import 'package:flutter/material.dart';

class MyTheme {
  static const Color primary = Color.fromRGBO(33, 69, 187, 1);

  static final ThemeData myTheme = ThemeData(
    primaryColor: primary,
    brightness: Brightness.dark, // Set brightness to dark for night mode
    fontFamily: 'Releway',
    appBarTheme: const AppBarTheme(
      color: primary,
      elevation: 10,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primary,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primary,
    ),
  );
}