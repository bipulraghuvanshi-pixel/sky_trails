import 'package:flutter/material.dart';

class RadarWidget extends StatelessWidget {
  const RadarWidget({
    super.key,
    this.size = 220,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            const Color(0xFF2F80ED).withValues(alpha: .10),
            const Color(0xFF2F80ED).withValues(alpha: .04),
            Colors.transparent,
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer Ring
          _buildRing(size),

          // Middle Ring
          _buildRing(size * .68),

          // Inner Ring
          _buildRing(size * .36),

          // Aircraft Dots
          _buildDot(
            top: size * .18,
            left: size * .55,
          ),

          _buildDot(
            top: size * .48,
            right: size * .12,
          ),

          _buildDot(
            bottom: size * .20,
            left: size * .18,
          ),

          // Center Glow
          Container(
            width: size * .28,
            height: size * .28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF2F80ED).withValues(alpha: .08),
            ),
          ),

          // Radar Icon
          const Icon(
            Icons.radar,
            color: Color(0xFF2F80ED),
            size: 58,
          ),
        ],
      ),
    );
  }

  Widget _buildRing(double diameter) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFF2F80ED).withValues(alpha: .18),
          width: 2,
        ),
      ),
    );
  }

  Widget _buildDot({
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: 10,
        height: 10,
        decoration: const BoxDecoration(
          color: Color(0xFF2F80ED),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}