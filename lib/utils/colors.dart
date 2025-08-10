import 'package:flutter/material.dart';

class MyColors {
  static final primaryColor = const Color.fromARGB(160, 201, 181, 8);
  static final ThemeData myTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.amber,
      primary: const Color.fromARGB(255, 208, 156, 0),
      onPrimary: Colors.white,
      secondary: Colors.amberAccent,
      onSecondary: Colors.white,
    ),
  );
}
