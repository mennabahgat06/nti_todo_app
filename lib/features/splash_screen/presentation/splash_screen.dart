import 'dart:async';
import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/app_assets.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_fonts.dart';
import 'package:todo_app/features/starting_screen/presentation/lets_start_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        // main content
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 1- logo
            Image.asset(AppAssets.splashBgPng, width: 170, height: 170),
            const SizedBox(height: 24),

            // 2- txt
            Text(
              'TODO',
              style: AppFonts.titleBold.copyWith(
                color: AppColors.primary,
                letterSpacing: 2.0,
                fontSize: 26,
              ),
            ),
          ],
        ),
      ),
    );
  }

// start automatically when object is created (when screen starts)
  @override
  void initState() {
    super.initState();
    Timer(

        // 1st parameter: duration

        const Duration(seconds: 2),

        // 2nd parameter: function to execute after duration

        () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const StartingScreen()),
        );
      }
    }

        //end

        );
  }
}

// Note: The `mounted` property is used to check if the widget is still in the widget tree before performing navigation. This prevents potential errors if the widget has been disposed of before the timer completes.
