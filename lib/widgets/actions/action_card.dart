import 'dart:math' as math;

import 'package:flutter/material.dart';

/// The original radar and refresh card, retaining the established layout,
/// typography, spacing, and light-blue visual hierarchy.
class ActionCard extends StatelessWidget {
  const ActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        height: 74,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white.withValues(alpha: 0.55)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF5C8DFF).withValues(alpha: 0.08),
              blurRadius: 25,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.35),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                ),
                child: Icon(icon, size: 22, color: const Color(0xFF2F80ED)),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Private experimental control retained without changing the public UI.
class InstrumentActionCard extends StatefulWidget {
  const InstrumentActionCard({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  State<InstrumentActionCard> createState() => _InstrumentActionCardState();
}

class _InstrumentActionCardState extends State<InstrumentActionCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _instrumentController;

  bool get _isRadar => widget.icon == Icons.radar;

  @override
  void initState() {
    super.initState();
    _instrumentController = AnimationController(
      vsync: this,
      duration: Duration(seconds: _isRadar ? 7 : 5),
    )..repeat();
  }

  @override
  void dispose() {
    _instrumentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accent = _isRadar ? const Color(0xFF6FE1CB) : const Color(0xFF8DBEFF);

    return Semantics(
      button: true,
      label: _isRadar ? 'Open aircraft radar' : 'Refresh aircraft data',
      child: AnimatedBuilder(
        animation: _instrumentController,
        builder: (context, _) {
          final phase = _instrumentController.value;
          return Material(
            color: Colors.transparent,
            shape: const CircleBorder(),
            child: InkResponse(
              onTap: widget.onTap,
              containedInkWell: true,
              highlightShape: BoxShape.circle,
              radius: 45,
              splashColor: accent.withValues(alpha: 0.15),
              highlightColor: accent.withValues(alpha: 0.06),
              child: Container(
                width: 78,
                height: 78,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    center: const Alignment(-0.28, -0.34),
                    radius: 1.05,
                    colors: [
                      Colors.white.withValues(alpha: 0.20),
                      const Color(0xFF102B4C).withValues(alpha: 0.66),
                      const Color(0xFF07162D).withValues(alpha: 0.82),
                    ],
                    stops: const [0, 0.46, 1],
                  ),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.32),
                    width: 0.8,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF020817).withValues(alpha: 0.48),
                      blurRadius: 18,
                      offset: const Offset(0, 10),
                    ),
                    BoxShadow(
                      color: accent.withValues(alpha: 0.13),
                      blurRadius: 22,
                      spreadRadius: -3,
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _InstrumentFacePainter(
                          accent: accent,
                          isRadar: _isRadar,
                          phase: phase,
                        ),
                      ),
                    ),
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF06182C).withValues(alpha: 0.42),
                        border: Border.all(
                          color: accent.withValues(alpha: 0.24),
                          width: 0.7,
                        ),
                      ),
                    ),
                    CustomPaint(
                      size: const Size(34, 34),
                      painter: _isRadar
                          ? _RadarGlyphPainter(accent)
                          : _SyncGlyphPainter(accent, phase),
                    ),
                    Positioned(
                      top: 9,
                      child: Container(
                        width: 24,
                        height: 1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1),
                          color: Colors.white.withValues(alpha: 0.27),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _InstrumentFacePainter extends CustomPainter {
  const _InstrumentFacePainter({
    required this.accent,
    required this.isRadar,
    required this.phase,
  });

  final Color accent;
  final bool isRadar;
  final double phase;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2;
    final fineLine = Paint()
      ..color = accent.withValues(alpha: 0.18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.65;

    canvas.drawCircle(center, radius - 6.5, fineLine);
    canvas.drawCircle(center, radius - 15, fineLine);

    if (isRadar) {
      canvas.drawLine(
        Offset(center.dx, 10),
        Offset(center.dx, size.height - 10),
        fineLine,
      );
      canvas.drawLine(
        Offset(10, center.dy),
        Offset(size.width - 10, center.dy),
        fineLine,
      );

      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate((phase * math.pi * 2) - math.pi / 2);
      final sweep = Paint()
        ..shader = SweepGradient(
          startAngle: 0,
          endAngle: math.pi / 1.8,
          colors: [
            accent.withValues(alpha: 0.28),
            accent.withValues(alpha: 0.05),
            Colors.transparent,
          ],
          stops: const [0, 0.38, 1],
        ).createShader(Rect.fromCircle(center: Offset.zero, radius: radius));
      canvas.drawArc(
        Rect.fromCircle(center: Offset.zero, radius: radius - 8),
        0,
        math.pi / 1.8,
        true,
        sweep,
      );
      canvas.drawLine(
        Offset.zero,
        Offset(radius - 8, 0),
        Paint()
          ..color = accent.withValues(alpha: 0.68)
          ..strokeWidth = 0.85,
      );
      canvas.restore();
    } else {
      final pulse = 0.55 + (math.sin(phase * math.pi * 2) * 0.25);
      canvas.drawCircle(
        center,
        radius - 10,
        Paint()
          ..color = accent.withValues(alpha: 0.05 + (pulse * 0.08))
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1,
      );
      for (final angle in [0.0, math.pi / 2, math.pi, math.pi * 1.5]) {
        final point = Offset(
          center.dx + math.cos(angle) * (radius - 8),
          center.dy + math.sin(angle) * (radius - 8),
        );
        canvas.drawCircle(
          point,
          1.25,
          Paint()..color = accent.withValues(alpha: pulse),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _InstrumentFacePainter oldDelegate) =>
      oldDelegate.phase != phase || oldDelegate.isRadar != isRadar;
}

class _RadarGlyphPainter extends CustomPainter {
  const _RadarGlyphPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final paint = Paint()
      ..color = color.withValues(alpha: 0.95)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: 12),
      -math.pi * .86,
      math.pi * 1.18,
      false,
      paint,
    );
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: 7),
      -math.pi * .78,
      math.pi * 1.02,
      false,
      paint,
    );
    canvas.drawLine(center, Offset(center.dx + 9, center.dy - 9), paint);
    canvas.drawCircle(center, 2.4, Paint()..color = color);
    canvas.drawCircle(
      Offset(center.dx + 10, center.dy - 10),
      1.6,
      Paint()..color = color.withValues(alpha: 0.9),
    );
  }

  @override
  bool shouldRepaint(covariant _RadarGlyphPainter oldDelegate) => false;
}

class _SyncGlyphPainter extends CustomPainter {
  const _SyncGlyphPainter(this.color, this.phase);

  final Color color;
  final double phase;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(phase * math.pi * 2);
    canvas.translate(-center.dx, -center.dy);
    final paint = Paint()
      ..color = color.withValues(alpha: 0.95)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.65
      ..strokeCap = StrokeCap.round;
    final bounds = Rect.fromCircle(center: center, radius: 10.5);
    canvas.drawArc(bounds, -math.pi * .1, math.pi * .72, false, paint);
    canvas.drawArc(bounds, math.pi * .9, math.pi * .72, false, paint);
    final arrow = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(center.dx + 12.5, center.dy - 2)
      ..lineTo(center.dx + 8.3, center.dy - 4.4)
      ..lineTo(center.dx + 9.2, center.dy + .7)
      ..close();
    canvas.drawPath(path, arrow);
    final returnPath = Path()
      ..moveTo(center.dx - 12.5, center.dy + 2)
      ..lineTo(center.dx - 8.3, center.dy + 4.4)
      ..lineTo(center.dx - 9.2, center.dy - .7)
      ..close();
    canvas.drawPath(returnPath, arrow);
    canvas.restore();
    canvas.drawCircle(
      center,
      1.7,
      Paint()..color = color.withValues(alpha: 0.82),
    );
  }

  @override
  bool shouldRepaint(covariant _SyncGlyphPainter oldDelegate) =>
      oldDelegate.phase != phase;
}
