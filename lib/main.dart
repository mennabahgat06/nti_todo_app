import 'package:flutter/material.dart';
import 'package:todo_app/features/splash_screen/splash_screen.dart';

// Entry point of the application
void main() {
  // Run the app and display the splash screen
  runApp(const MannonaTODOAPP());
}

class MannonaTODOAPP extends StatelessWidget {
  const MannonaTODOAPP({super.key});

  @override
  Widget build(BuildContext context) {
    // the main framework of the app, which provides the basic structure and navigation
    return MaterialApp(
      title: 'Mannona TODO App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
