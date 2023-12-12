import 'package:flutter/material.dart';

class Constants {
  static final ThemeData myTheme = ThemeData(
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          foregroundColor: Colors.white),
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
      useMaterial3: true,
      inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.black),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple)),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple))));
}
