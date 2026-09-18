import 'package:flutter/material.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_fonts.dart';

class EmptyTaskWidget extends StatelessWidget {
  const EmptyTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'There are no tasks yet,\nPress the button\nTo add New Task',
            textAlign: TextAlign.center,
            style: AppFonts.bodyRegular,
          ),
          const SizedBox(height: 24),
          Image.asset(AppAssets.noTasksPng, height: 210),
        ],
      ),
    );
  }
}
