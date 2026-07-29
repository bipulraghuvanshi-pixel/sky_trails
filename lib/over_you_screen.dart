import 'package:flutter/material.dart';

class OverYouScreen extends StatelessWidget {
  const OverYouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/sky_background.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}