import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/storage/token_storage.dart';
import '../../home_screen/presentation/home_screen.dart';
import '../../starting_screen/presentation/lets_start_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    final token = await TokenStorage.getAccessToken();
    if (token != null && token.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LetsStartScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAssets.splashBgPng, width: 170, height: 170),
            const SizedBox(height: 24),
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
}
