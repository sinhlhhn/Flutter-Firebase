import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.green[400],
  ),
  primaryColor: Colors.green[400],
  backgroundColor: Colors.grey[300],
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: Colors.green[400],
      splashFactory: NoSplash.splashFactory,
    ),
  ),
);

ThemeData darkTheme = ThemeData.dark().copyWith();
