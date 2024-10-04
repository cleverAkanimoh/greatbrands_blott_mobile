import 'package:flutter/material.dart';
import 'package:greatbrands_blott_mobile/app_config.dart';
import 'package:greatbrands_blott_mobile/screens/splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:one_context/one_context.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: brandName,
      builder: OneContext().builder,
      navigatorKey: OneContext().key,
      color: Colors.white,
      theme: ThemeData(
        scaffoldBackgroundColor: bgColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          surface: whiteColor,
        ),
        fontFamily: GoogleFonts.roboto().fontFamily,
        useMaterial3: true,
      ),
      home: const Splash(),
    );
  }
}
