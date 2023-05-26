import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  bool showHealth = false;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      setState(() {
        showHealth = true;
      });
      Timer(const Duration(milliseconds: 500), () {
        Navigator.pushReplacementNamed(context, '/home');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Cx',
              style: TextStyle(
                fontFamily: 'Martian_robotics',
                fontSize: 64,
              ),
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 800),
              opacity: showHealth ? 1.0 : 0.0,
              child: const Text(
                'Health',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
