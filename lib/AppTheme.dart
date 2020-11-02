import 'package:flutter/material.dart';

class AppTheme {
  //
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.teal,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: Colors.white70,
      backgroundColor: Colors.teal,
    ),
    brightness: Brightness.light,
  );

  static final ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.teal,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: Colors.black,
    backgroundColor: Colors.teal,
  ),
  brightness: Brightness.dark,
  );
}
