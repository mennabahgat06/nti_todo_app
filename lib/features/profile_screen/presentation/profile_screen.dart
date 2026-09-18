import 'package:flutter/material.dart';
import 'package:nti_todo_app/core/services/auth_service.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/storage/token_storage.dart';
import '../../login_screen/presentation/login_screen.dart';
import 'change_password_screen.dart';
import 'profile_menu_item.dart';
import 'settings_screen.dart';
import 'update_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _authService = AuthService();
  String _username = 'Ahmed Saber';

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      final user = await _authService.getUserData();
      if (mounted) {
        setState(() => _username = user.username);
      }
    } catch (_) {
      final cached = await TokenStorage.getUsername();
      if (cached != null && mounted) {
        setState(() => _username = cached);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              size: 18, color: AppColors.textBlack),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage(AppAssets.flagPng),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hello!',
                          style: AppFonts.bodyRegular.copyWith(fontSize: 12)),
                      Text(_username,
                          style: AppFonts.titleBold.copyWith(fontSize: 16)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 36),
              ProfileMenuItem(
                icon: Icons.person_outline,
                title: 'Profile',
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            UpdateProfileScreen(currentUsername: _username)),
                  );
                  _loadUser();
                },
              ),
              ProfileMenuItem(
                icon: Icons.lock_outline,
                title: 'Change Password',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChangePasswordScreen()),
                  );
                },
              ),
              ProfileMenuItem(
                icon: Icons.settings_outlined,
                title: 'Settings',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsScreen()),
                  );
                },
              ),
              ProfileMenuItem(
                icon: Icons.logout,
                title: 'Logout',
                onTap: () async {
                  await TokenStorage.clear();
                  if (!mounted) return;
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
