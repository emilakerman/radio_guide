import 'package:flutter/material.dart';
import 'package:radio_guide/routing/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,

      // home: Scaffold(
      //   backgroundColor: AppColors.primary,
      //   body: StartPage(),
      // ),
    );
  }
}
