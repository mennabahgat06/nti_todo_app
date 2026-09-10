import 'package:flutter/material.dart';
import '../core/utils/app_assets.dart';
import '../core/utils/app_colors.dart';
import '../core/utils/app_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(AppAssets.headerFlag),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello!',
                        style: AppFonts.bodyRegular.copyWith(fontSize: 12),
                      ),
                      Text(
                        'Ahmed Saber',
                        style: AppFonts.titleBold.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Center(
              child: Column(
                children: [
                  const Text(
                    'There are no tasks yet,\nPress the button\nTo add New Task',
                    textAlign: TextAlign.center,
                    style: AppFonts.bodyRegular,
                  ),
                  const SizedBox(height: 24),
                  Image.asset(AppAssets.emptyTasksIllustration, height: 200),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onPressed: () {
          // Action for adding new task
        },
        child: const Icon(Icons.note_add_outlined, color: AppColors.white),
      ),
    );
  }
}
