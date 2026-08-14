import 'package:flutter/material.dart';

import 'aircraft_icon.dart';

class CinematicAircraft extends StatelessWidget {
  final Animation<double> animation;
  final Offset start;
  final Offset controlA;
  final Offset controlB;
  final Offset end;
  final double rotation;

  const CinematicAircraft({
    super.key,
    required this.animation,
    required this.start,
    required this.controlA,
    required this.controlB,
    required this.end,
    this.rotation = 1.5708,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          final t = animation.value;
          final position = _cubicPoint(t, start, controlA, controlB, end);
          final tangent = _cubicTangent(t, start, controlA, controlB, end);
          final angle = tangent.direction + rotation;

          return Stack(
            clipBehavior: Clip.none,
            children: [
              CustomPaint(
                size: Size.infinite,
                painter: _ContrailPathPainter(
                  progress: t,
                  start: start,
                  controlA: controlA,
                  controlB: controlB,
                  end: end,
                ),
              ),
              Positioned(
                left: position.dx - 26,
                top: position.dy - 26,
                child: Transform.rotate(
                  alignment: Alignment.center,
                  angle: angle,
                  child: child,
                ),
              ),
            ],
          );
        },
        child: const AircraftIcon(),
      ),
    );
  }

  Offset _cubicPoint(double t, Offset p0, Offset p1, Offset p2, Offset p3) {
    final inverse = 1 - t;
    return p0 * (inverse * inverse * inverse) +
        p1 * (3 * inverse * inverse * t) +
        p2 * (3 * inverse * t * t) +
        p3 * (t * t * t);
  }

  Offset _cubicTangent(double t, Offset p0, Offset p1, Offset p2, Offset p3) {
    final inverse = 1 - t;
    return (p1 - p0) * (3 * inverse * inverse) +
        (p2 - p1) * (6 * inverse * t) +
        (p3 - p2) * (3 * t * t);
  }
}

class _ContrailPathPainter extends CustomPainter {
  final double progress;
  final Offset start;
  final Offset controlA;
  final Offset controlB;
  final Offset end;

  const _ContrailPathPainter({
    required this.progress,
    required this.start,
    required this.controlA,
    required this.controlB,
    required this.end,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0.02) return;

    final path = Path()..moveTo(start.dx, start.dy);
    for (var i = 1; i <= 36; i++) {
      final t = progress * i / 36;
      final point = _point(t);
      path.lineTo(point.dx, point.dy);
    }

    final trail = Paint()
      ..color = const Color(0xFF9CCBFF).withValues(alpha: 0.20)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
    canvas.drawPath(path, trail);

    final core = Paint()
      ..color = Colors.white.withValues(alpha: 0.50)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.2;
    canvas.drawPath(path, core);
  }

  Offset _point(double t) {
    final inverse = 1 - t;
    return start * (inverse * inverse * inverse) +
        controlA * (3 * inverse * inverse * t) +
        controlB * (3 * inverse * t * t) +
        end * (t * t * t);
  }

  @override
  bool shouldRepaint(covariant _ContrailPathPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
