import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:radio_guide/src/constants/app_colors.dart';
import 'package:radio_guide/src/routing/app_router.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: ThemeData(
        textTheme: TextTheme(
          displayLarge: const TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: GoogleFonts.alatsi(
            fontSize: 22,
          ),
          bodyMedium: GoogleFonts.merriweather(),
          displaySmall: GoogleFonts.pacifico(),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(color: AppColors.additional, fontSize: 22),
          centerTitle: true,
          backgroundColor: AppColors.transparent,
          shadowColor: AppColors.transparent,
        ),
      ),
    );
  }
}
