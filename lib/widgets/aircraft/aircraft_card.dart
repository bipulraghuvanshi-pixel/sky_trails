import 'package:flutter/material.dart';
import '../../models/aircraft.dart';

class AircraftCard extends StatelessWidget {
  const AircraftCard({
    super.key,
    required this.plane,
    required this.retroMode,
    required this.onTap,
  });

  final Aircraft plane;
  final bool retroMode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(
          color: retroMode
              ? const Color(0xFF111111)
              : Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: retroMode
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(.05),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
        ),

        child: Row(
          children: [

            /// Aircraft Icon
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: retroMode
                    ? Colors.green.withOpacity(.12)
                    : const Color(0xFFF3F8FF),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.flight,
                size: 32,
                color: retroMode
                    ? Colors.greenAccent
                    : const Color(0xFF163D7A),
              ),
            ),

            const SizedBox(width: 18),

            /// Aircraft Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    plane.callsign,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: retroMode
                          ? Colors.greenAccent
                          : const Color(0xFF0F172A),
                    ),
                  ),

                  const SizedBox(height: 6),

                  Row(
                    children: [

                      const Text(
                        "🌍",
                        style: TextStyle(fontSize: 16),
                      ),

                      const SizedBox(width: 6),

                      Expanded(
                        child: Text(
                          plane.country,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15,
                            color: retroMode
                                ? Colors.greenAccent
                                : Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),

                   
                ],
              ),
            ),

            const SizedBox(width: 10),

            /// Distance Badge
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: retroMode
                    ? Colors.green.withOpacity(.15)
                    : const Color(0xFFEAF3FF),
                borderRadius: BorderRadius.circular(14),
              ),
            child: Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    Icon(
  Icons.location_on,
  size: 15,
  color: retroMode
      ? Colors.greenAccent
      : Colors.redAccent,
),
    const SizedBox(width: 4),
    Text(
      "${plane.distance.toStringAsFixed(1)} km",
      style: TextStyle(
        fontWeight: FontWeight.w700,
        color: retroMode
            ? Colors.greenAccent
            : const Color(0xFF2F80ED),
      ),
    ),
  ],
),
            ),
          ],
        ),
      ),
    );
  }
}