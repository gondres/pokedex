import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokedex_app/ui/home_page.dart';
import 'package:pokedex_app/ui/splash_screen_page.dart';
import 'package:pokedex_app/utils/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(debugShowCheckedModeBanner: false, theme: AppTheme.theme, home: const SplashScreenPage()),
    );
  }
}
