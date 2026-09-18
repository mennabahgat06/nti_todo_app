import 'package:flutter/material.dart';
import 'package:nti_todo_app/core/storage/token_storage.dart';
import 'features/splash_screen/presentation/splash_screen.dart';

final ValueNotifier<Locale> appLocaleNotifier =
    ValueNotifier<Locale>(const Locale('en'));

void main() async {
  // save selected lang (ar - eng)

  WidgetsFlutterBinding.ensureInitialized();
  final savedLang = await TokenStorage.getLanguage();
  appLocaleNotifier.value = Locale(savedLang);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: appLocaleNotifier,
      builder: (context, currentLocale, child) {
        return MaterialApp(
          title: 'NTI ToDo App',
          debugShowCheckedModeBanner: false,
          locale: currentLocale,
          supportedLocales: const [Locale('en'), Locale('ar')],
          theme: ThemeData(
            fontFamily: 'Poppins',
            useMaterial3: true,
          ),
/*
          supportedLocales: const [
            Locale('en'),
            Locale('ar'),
          ],

          // مندوبو الترجمة لتفعيل اتجاه RTL والنصوص الافتراضية
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          */
          home: const SplashScreen(),
        );
      },
    );
  }
}
