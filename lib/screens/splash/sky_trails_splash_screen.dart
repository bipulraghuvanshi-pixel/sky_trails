import 'package:flutter/material.dart';
import '../../landing_screen.dart';
import '../widgets/cloud_outline.dart';

class SkyTrailsSplashScreen extends StatefulWidget {
  const SkyTrailsSplashScreen({super.key});

  @override
  State<SkyTrailsSplashScreen> createState() =>
      _SkyTrailsSplashScreenState();
}

class _SkyTrailsSplashScreenState extends State<SkyTrailsSplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LandingScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    CloudOutline(
      width: 60,
      height: 35,
    ),
    CloudOutline(
      width: 75,
      height: 42,
    ),
  ],
),

const SizedBox(height: 20),
              CloudOutline(
  width: 65,
  height: 38,
),
              SizedBox(height: 20),
              Image.asset(
  'assets/images/sky_trails_logo.png',
  width: 180,
),
              SizedBox(height: 32),
              Text(
                "Reading the Sky...",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}