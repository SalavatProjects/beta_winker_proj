import 'package:beta_winker_proj/pages/main_page.dart';
import 'package:beta_winker_proj/ui_kit/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.white,
          useMaterial3: true,
        ),
        home: const MainPage(),
      ),
    );
  }
}


