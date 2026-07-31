import 'package:flutter/material.dart';

class CloudOutline extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final double strokeWidth;

  const CloudOutline({
    super.key,
    this.width = 90,
    this.height = 50,
    this.color = const Color(0xFFD9D9D9),
    this.strokeWidth = 2,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: _CloudOutlinePainter(
          color: color,
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}

class _CloudOutlinePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  _CloudOutlinePainter({
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();

    path.moveTo(size.width * 0.20, size.height * 0.70);

    path.quadraticBezierTo(
      size.width * 0.10,
      size.height * 0.70,
      size.width * 0.10,
      size.height * 0.55,
    );

    path.quadraticBezierTo(
      size.width * 0.10,
      size.height * 0.35,
      size.width * 0.30,
      size.height * 0.35,
    );

    path.quadraticBezierTo(
      size.width * 0.35,
      size.height * 0.10,
      size.width * 0.55,
      size.height * 0.20,
    );

    path.quadraticBezierTo(
      size.width * 0.65,
      0,
      size.width * 0.80,
      size.height * 0.20,
    );

    path.quadraticBezierTo(
      size.width * 0.95,
      size.height * 0.20,
      size.width * 0.95,
      size.height * 0.45,
    );

    path.quadraticBezierTo(
      size.width * 0.95,
      size.height * 0.70,
      size.width * 0.75,
      size.height * 0.70,
    );

    path.lineTo(size.width * 0.20, size.height * 0.70);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}