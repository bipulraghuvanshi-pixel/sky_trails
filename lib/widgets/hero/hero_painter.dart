import 'package:flutter/material.dart';

class RadarPainter extends CustomPainter {
  const RadarPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    _drawAtmosphere(canvas, center, radius);
    _drawRings(canvas, center, radius);
    _drawCenter(canvas, center);
    _drawAircraftDots(canvas, center, radius);
  }

  void _drawAtmosphere(
    Canvas canvas,
    Offset center,
    double radius,
  ) {
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF2F80ED).withValues(alpha: .08),
          const Color(0xFF2F80ED).withValues(alpha: .03),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromCircle(center: center, radius: radius),
      );

    canvas.drawCircle(center, radius, paint);
  }

  void _drawRings(
    Canvas canvas,
    Offset center,
    double radius,
  ) {
    final paint = Paint()
      ..color = const Color(0xFF2F80ED).withValues(alpha: .16)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;

    canvas.drawCircle(center, radius, paint);
    canvas.drawCircle(center, radius * .70, paint);
    canvas.drawCircle(center, radius * .40, paint);
  }

  void _drawCenter(
    Canvas canvas,
    Offset center,
  ) {
    final glow = Paint()
      ..color = const Color(0xFF2F80ED).withValues(alpha: .10);

    canvas.drawCircle(center, 24, glow);

    final core = Paint()
      ..color = const Color(0xFF2F80ED);

    canvas.drawCircle(center, 7, core);

    final outline = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = Colors.white;

    canvas.drawCircle(center, 12, outline);
  }

  void _drawAircraftDots(
    Canvas canvas,
    Offset center,
    double radius,
  ) {
    final paint = Paint()
      ..color = const Color(0xFF2F80ED);

    final dots = <Offset>[
      Offset(
        center.dx,
        center.dy - radius * .72,
      ),
      Offset(
        center.dx + radius * .62,
        center.dy,
      ),
      Offset(
        center.dx - radius * .55,
        center.dy + radius * .45,
      ),
    ];

    for (final dot in dots) {
      canvas.drawCircle(dot, 4.5, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}