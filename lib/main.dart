import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:coffe_app_ui/presentation/routes/app_router.dart';
import 'package:coffe_app_ui/presentation/theme/colors.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Coffee App',
      theme: AppColors.theme,
      routerConfig: appRouter,
    );
  }
}
