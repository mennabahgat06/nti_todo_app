import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final IconData? prefixIcon;
  final bool isPassword;
  final bool isObscured;
  final VoidCallback? onToggleVisibility;

  const CustomTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.prefixIcon,
    this.isPassword = false,
    this.isObscured = false,
    this.onToggleVisibility,
    InputDecoration? decoration,
    int? maxLines,
    bool? readOnly,
    Future<Null> Function()? onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.fieldFill,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.fieldBorder),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? isObscured : false,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          prefixIcon: Icon(prefixIcon, color: AppColors.textGrey, size: 20),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    isObscured ? Icons.lock_outline : Icons.lock_open,
                    color: AppColors.textGrey,
                    size: 20,
                  ),
                  onPressed: onToggleVisibility,
                )
              : null,
          hintText: hintText,
          hintStyle: AppFonts.inputLabel,
        ),
      ),
    );
  }
}
