import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../models/aircraft.dart';
import '../widgets/sky/sky_background.dart';
import 'aircraft_details_page.dart';

class RadarPage extends StatefulWidget {
  const RadarPage({
    super.key,
    required this.nearbyPlanes,
    required this.userLat,
    required this.userLon,
  });

  final List<Aircraft> nearbyPlanes;
  final double userLat;
  final double userLon;

  @override
  State<RadarPage> createState() => _RadarPageState();
}

class _RadarPageState extends State<RadarPage> with TickerProviderStateMixin {
  static const int _maxTrailPoints = 1440;
  static const double _coordinateScale = 0.22;
  static const double _flightTravelRatio = 1.67;

  late final AnimationController _controller;
  late final AnimationController _pulseController;
  final Map<String, List<Offset>> _planeTrails = {};
  double? _radarRadius;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 30))
          ..addListener(_recordPlaneTrailFrame)
          ..forward();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  void _recordPlaneTrailFrame() {
    final radarRadius = _radarRadius;
    if (radarRadius == null || radarRadius <= 0) return;

    for (final plane in widget.nearbyPlanes) {
      // Trails are stored in radar-radius units, so they resize with the face.
      final point =
          _planeOffset(plane, radarRadius, _controller.value) / radarRadius;
      final trail = _planeTrails.putIfAbsent(plane.callsign, () => []);
      trail.add(point);
      if (trail.length > _maxTrailPoints) trail.removeAt(0);
    }
  }

  Offset _planeOffset(Aircraft plane, double radius, double flightCycle) {
    final heading = (plane.heading ?? 0) * math.pi / 180;
    final movement = radius * _flightTravelRatio * flightCycle;
    final floatY =
        math.sin((flightCycle * math.pi * 2) + plane.latitude) * radius * 0.008;

    return Offset(
      ((plane.longitude - widget.userLon) * radius * _coordinateScale) +
          (math.sin(heading) * movement),
      -((plane.latitude - widget.userLat) * radius * _coordinateScale) -
          (math.cos(heading) * movement) +
          floatY,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF7BAEFF), size: 26),
      ),
      body: SkyBackground(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final radarDiameter = constraints.biggest.shortestSide;
            final radarRadius = radarDiameter / 2;
            _radarRadius = radarRadius;

            return Center(
              child: SizedBox.square(
                dimension: radarDiameter,
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    final radarCenter = Offset(radarRadius, radarRadius);
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ..._planeTrails.values.map(
                          (trail) => CustomPaint(
                            size: Size.square(radarDiameter),
                            painter: PlaneTrailPainter(trail),
                          ),
                        ),
                        ...widget.nearbyPlanes.map((plane) {
                          final markerCenter =
                              radarCenter +
                              _planeOffset(
                                plane,
                                radarRadius,
                                _controller.value,
                              );
                          return _AircraftMarker(
                            plane: plane,
                            heading: (plane.heading ?? 0) * math.pi / 180,
                            center: markerCenter,
                          );
                        }),
                        const Align(
                          alignment: Alignment(0, -0.18),
                          child: Text(
                            'N',
                            style: TextStyle(
                              color: Color(0x3B6FA8FF),
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Center(
                          child: AnimatedBuilder(
                            animation: _pulseController,
                            builder: (context, child) => Transform.scale(
                              scale: 1 + (_pulseController.value * 0.12),
                              child: child,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xFF5C8DFF,
                                    ).withValues(alpha: 0.25),
                                    blurRadius: 14,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.location_on,
                                size: 22,
                                color: Color(0xFF5C8DFF),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _AircraftMarker extends StatelessWidget {
  const _AircraftMarker({
    required this.plane,
    required this.heading,
    required this.center,
  });

  final Aircraft plane;
  final double heading;
  final Offset center;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      // This centers the marker's fixed hit target on its radar coordinate.
      left: center.dx - 36,
      top: center.dy - 20,
      width: 72,
      height: 40,
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => AircraftDetailsPage(plane: plane)),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                plane.callsign,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xFF8AB4FF),
                  fontSize: 7,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2563EB).withValues(alpha: 0.35),
                    blurRadius: 16,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: Transform.rotate(
                angle: heading,
                child: const Icon(
                  Icons.airplanemode_active,
                  color: Color(0xFF2563EB),
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlaneTrailPainter extends CustomPainter {
  const PlaneTrailPainter(this.points);

  final List<Offset> points;

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2) return;

    final center = size.center(Offset.zero);
    final radius = size.shortestSide / 2;
    for (var i = 1; i < points.length; i++) {
      final age = i / (points.length - 1);
      final behindPlane = 1 - age;
      final dissolve = math.pow(age, 0.7).toDouble();
      final segment = Path()
        ..moveTo(
          center.dx + (points[i - 1].dx * radius),
          center.dy + (points[i - 1].dy * radius),
        )
        ..lineTo(
          center.dx + (points[i].dx * radius),
          center.dy + (points[i].dy * radius),
        );

      canvas.drawPath(
        segment,
        Paint()
          ..color = const Color(0xFF8FC5FF).withValues(alpha: dissolve * 0.18)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5 + (behindPlane * 2.4)
          ..strokeCap = StrokeCap.round,
      );
      canvas.drawPath(
        segment,
        Paint()
          ..color = const Color(0xFFE2F1FF).withValues(alpha: dissolve * 0.48)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.65 + (behindPlane * 0.7)
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  @override
  bool shouldRepaint(covariant PlaneTrailPainter oldDelegate) => true;
}
