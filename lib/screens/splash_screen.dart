import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodreviewapp/widgets/screen_navigator.dart';

// Splash Screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const ScreenNavigator(),
        ),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              height: 300,
              child: Theme.of(context).brightness == Brightness.light
                  ? Image.asset('assets/icons/logo.png')
                  : Image.asset('assets/icons/logo_white.png'),
            ),
            const Text(
              'Tabemashou',
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
            const Text(
              "たべましょう",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w100),
            ),
            const SizedBox(height: 20.0),
            const LinearProgressIndicator(color: Colors.yellowAccent),
            const SizedBox(height: 125.0),
          ],
        ),
      ),
    );
  }
}
