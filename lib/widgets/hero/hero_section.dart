import 'package:flutter/material.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.aircraftCount,
    required this.lastUpdated,
    required this.retroMode,
  });

  final int aircraftCount;
  final DateTime? lastUpdated;
  final bool retroMode;

  String _formatTime(DateTime? dateTime) {
    if (dateTime == null) return '--';

    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');

    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
      child: Column(
        children: [
          //--------------------------------------------
          // Hero Radar
          //--------------------------------------------
          Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.blue.withValues(alpha: .10),
                  Colors.blue.withValues(alpha: .03),
                  Colors.transparent,
                ],
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.blue.withValues(alpha: .12),
                      width: 2,
                    ),
                  ),
                ),
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.blue.withValues(alpha: .25),
                      width: 2,
                    ),
                  ),
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue.withValues(alpha: .08),
                  ),
                ),
                const Icon(
                  Icons.radar,
                  size: 60,
                  color: Color(0xFF2F80ED),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          //--------------------------------------------
          // Title
          //--------------------------------------------
          const Text(
            'Over You',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w800,
              letterSpacing: -.5,
              color: Color(0xFF0F172A),
            ),
          ),

          const SizedBox(height: 8),

          //--------------------------------------------
          // Aircraft Count
          //--------------------------------------------
          Text(
            '$aircraftCount Aircraft Nearby',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2F80ED),
            ),
          ),

          const SizedBox(height: 18),

          //--------------------------------------------
          // Live Status
          //--------------------------------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFF22C55E),
                  shape: BoxShape.circle,
                ),
              ),

              const SizedBox(width: 8),

              const Text(
                'LIVE',
                style: TextStyle(
                  color: Color(0xFF22C55E),
                  fontWeight: FontWeight.w700,
                  letterSpacing: .8,
                ),
              ),

              const SizedBox(width: 18),

              Container(
                width: 1,
                height: 16,
                color: Colors.grey.shade300,
              ),

              const SizedBox(width: 18),

              Text(
                'Updated ${_formatTime(lastUpdated)}',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}