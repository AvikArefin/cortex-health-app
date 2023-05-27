import 'package:cortex/pages/start.dart';
import 'package:flutter/material.dart';
import 'package:cortex/pages/splash.dart';

void main() {
  runApp(const CortexHealthApp());
}

class CortexHealthApp extends StatelessWidget {
  const CortexHealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
      ),
      home: const SplashScreen(),
      routes: {
        '/home': (context) => const StartPage(),
        // '/home': (context) => QRCode(),
      },
    );
  }
}
