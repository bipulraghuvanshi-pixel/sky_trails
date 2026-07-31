import 'package:flutter/material.dart';

class AircraftDetailTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final bool retroMode;

  const AircraftDetailTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.retroMode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 18,
      ),
      decoration: BoxDecoration(
        color: retroMode
            ? const Color(0xFF151515)
            : Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: retroMode
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: retroMode
                ? Colors.greenAccent
                : Colors.blue,
            size: 24,
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
                color: retroMode
                    ? Colors.greenAccent.withValues(alpha: 0.75)
                    : Colors.grey,
              ),
            ),
          ),

          Container(
            width: 1,
            height: 28,
            color: retroMode
                ? Colors.greenAccent.withValues(alpha: 0.25)
                : Colors.grey.shade300,
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: retroMode
                    ? Colors.greenAccent
                    : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}