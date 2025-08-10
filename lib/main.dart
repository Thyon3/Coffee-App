import 'package:coffe_app_ui/screens/splas_screen.dart';
import 'package:coffe_app_ui/utils/colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: MyColors.myTheme,
      home: SplashScreen(),
    );
  }
}
