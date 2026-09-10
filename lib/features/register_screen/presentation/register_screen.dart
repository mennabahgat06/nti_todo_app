import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/app_assets.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_fonts.dart';
import 'package:todo_app/core/widgets/custom_txt_field.dart';
import 'package:todo_app/features/login_screen/presentation/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // controllers for the text fields
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

// variables to manage the visibility of password fields
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appearance of the screen
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          // main content of the screen
          children: [
            /// ***************** 1- Header ****************************************

            // 1- header image with "Pick Image" button
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                // first widg in stake
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(28),
                    bottomRight: Radius.circular(28),
                  ),
                  child: Image.asset(
                    AppAssets.headerFlag,
                    width: double.infinity,
                    height: 240,
                    fit: BoxFit.cover,
                  ),
                ),

                // second widg in stake
                Positioned(
                  bottom: -15, // TRY : 00

                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Text(
                      'Pick Image',
                      style: TextStyle(fontSize: 12, color: AppColors.textGrey),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 36),

            /// ***************** 2- Registration Form ****************************************

            // 2- form fields and buttons

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  // 1- username
                  CustomTextField(
                    controller: _usernameController,
                    hintText: 'Username',
                    prefixIcon: Icons.person_outline,
                  ),
                  const SizedBox(height: 16),

                  // 2- password
                  CustomTextField(
                    controller: _passwordController,
                    hintText: 'Password',
                    prefixIcon: Icons.lock_outline,
                    isPassword: true,
                    isObscured: _obscurePassword,
                    onToggleVisibility: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  const SizedBox(height: 16),

                  // 3- confirm password
                  CustomTextField(
                    controller: _confirmPasswordController,
                    hintText: 'Confirm Password',
                    prefixIcon: Icons.lock_outline,
                    isPassword: true,
                    isObscured: _obscureConfirmPassword,
                    onToggleVisibility: () => setState(() =>
                        _obscureConfirmPassword = !_obscureConfirmPassword),
                  ),
                  const SizedBox(height: 24),

                  // 4- register button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      },
                      child: const Text('Register', style: AppFonts.buttonText),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // 5- login link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already Have An Account? ',
                          style: AppFonts.bodyRegular),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                          );
                        },
                        child: Text(
                          'Login',
                          style: AppFonts.bodyRegular.copyWith(
                            color: AppColors.textBlack,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
