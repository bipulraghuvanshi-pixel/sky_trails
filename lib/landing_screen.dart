import 'package:flutter/material.dart';
import 'main.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
       decoration: const BoxDecoration(
  color: Colors.white,
),
        child: Center(
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
     GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SkyTrailsApp(),
      ),
    );
  },
  child: Image.asset(
    'assets/images/sky_trails_logo.png',
    width: 320,
  ),
),

      const SizedBox(height: 5),

      Container(
        width: 360,
        height: 64,
     decoration: BoxDecoration(
  color: Colors.white.withValues(alpha: 0.75),
  borderRadius: BorderRadius.circular(30),
  boxShadow: [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.08),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ],
),
        child:  TextField(
          decoration: InputDecoration(
            hintText: 'Search flight',
            contentPadding: EdgeInsets.symmetric(
  vertical: 18,
),
           hintStyle: TextStyle(
  color: Color(0xFF5C8DFF),
  fontSize: 18,
  fontWeight: FontWeight.w300,
),
            prefixIcon: const Icon(
  Icons.search,
  color: Color(0xFF5C8DFF),
),
            border: InputBorder.none,
          ),
        ),
      ),
    ],
  ),
),
      ),
    );
  }
}