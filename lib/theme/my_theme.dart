import 'dart:ui';

import 'package:flutter/material.dart';

final ThemeData myTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.yellow,
    primarySwatch: Colors.indigo,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 19, 71, 185),
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontSize: 22,
      ),
    ),
    textTheme: const TextTheme(
      bodySmall: TextStyle(
        fontSize: 14,
        color: Colors.yellow,
      ),
      bodyMedium: TextStyle(
        fontSize: 8,
        color: Colors.black,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
        fillColor: Colors.black,
        labelStyle: TextStyle(
          color: Colors.yellow,
        )));
