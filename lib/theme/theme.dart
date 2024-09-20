import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  useMaterial3: true,
  primaryColor: Colors.indigo,
  scaffoldBackgroundColor: Colors.black,
  dividerColor: Colors.white24,
  colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.indigo, brightness: Brightness.dark),
  appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white),
      elevation: 0,
      backgroundColor: Colors.black,
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700)),
  listTileTheme: const ListTileThemeData(iconColor: Colors.white),
  textTheme: TextTheme(
    bodyMedium: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 20
    ),
    labelSmall: TextStyle(
      color: Colors.white.withOpacity(0.6),
      fontWeight: FontWeight.w700,
      fontSize: 14
    ),
    headlineMedium: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 24
    ),
    titleMedium: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: 26
    ),
  )
);
