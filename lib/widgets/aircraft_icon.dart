import 'package:flutter/material.dart';

/// The single aircraft visual used by both the landing interaction and intro.
class AircraftIcon extends StatelessWidget {
  const AircraftIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.airplanemode_active,
      size: 52,
      color: Color(0xFF5C8DFF),
    );
  }
}
