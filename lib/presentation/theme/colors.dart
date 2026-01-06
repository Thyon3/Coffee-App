import 'package:flutter/material.dart';

class AppColors {
  static final primaryColor = const Color.fromARGB(160, 201, 181, 8);
  static final ThemeData theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.amber,
      primary: const Color.fromARGB(255, 208, 156, 0),
      onPrimary: Colors.white,
      secondary: Colors.amberAccent,
      onSecondary: Colors.white,
    ),
  );
}
