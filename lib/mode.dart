import 'package:flutter/material.dart';


final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.black,
  secondaryHeaderColor: Colors.black,
  scaffoldBackgroundColor: Colors.white,
  cardColor: Colors.white.withOpacity(0.2),
  iconTheme: const IconThemeData(color: Colors.black),
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: Colors.black,
    border: OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black54),
    ),
    labelStyle: TextStyle(color: Colors.black),
    hintStyle: TextStyle(color: Colors.black45),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black, fontSize: 18),

    bodyMedium: TextStyle(color: Colors.black54),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.white,
  secondaryHeaderColor: Colors.white,
  scaffoldBackgroundColor: Colors.black,
  cardColor: Colors.black.withOpacity(0.2),
  iconTheme: const IconThemeData(color: Colors.white),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.black,
    border: const OutlineInputBorder(),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white54),
    ),
    labelStyle: const TextStyle(color: Colors.white),
    hintStyle: const TextStyle(color: Colors.white60),
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white, fontSize: 18),
    bodyMedium: TextStyle(color: Colors.white70),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),

  ),

);