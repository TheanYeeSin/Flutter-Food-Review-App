import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:foodreviewapp/l10n/l10n.dart';
import 'package:foodreviewapp/screens/home_screen.dart';
import 'package:foodreviewapp/utils/style.dart';
import 'package:foodreviewapp/utils/language.dart';
import 'package:provider/provider.dart';
import 'package:foodreviewapp/utils/notification.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodreviewapp/utils/display.dart';
import 'package:foodreviewapp/screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationManager.initialize();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeManager()),
        ChangeNotifierProvider(create: (context) => LanguageManager()),
        ChangeNotifierProvider(create: (context) => DisplayManager()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: context.watch<ThemeManager>().themeMode,
      supportedLocales: L10n.all,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      locale: context.watch<LanguageManager>().locale,
    );
  }
}
