import 'package:flutter/material.dart';

import 'main.dart';
import 'widgets/animated_plane.dart';
import 'widgets/cinematic_aircraft.dart';
import 'widgets/notification/notification_button.dart';
import 'widgets/location/location_display.dart';
import 'widgets/sky/sky_background.dart';
import 'services/location_service.dart';

class LandingScreen extends StatefulWidget {
  final bool playIntro;

  const LandingScreen({super.key, this.playIntro = false});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with SingleTickerProviderStateMixin {
  bool showSearch = false;
  bool showLogo = false;
  late final AnimationController _introController;
  late bool _introComplete;

  final LocationService locationService = const LocationService();

  LocationData? location;
  @override
  void initState() {
    super.initState();

    _introComplete = !widget.playIntro;
    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );
    _introController.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        setState(() => _introComplete = true);
      }
    });
    if (widget.playIntro) {
      _introController.forward();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() => showLogo = true);
      }
    });

    loadLocation();
  }

  Future<void> loadLocation() async {
    final result = await locationService.getLocation();

    if (!mounted) return;

    setState(() {
      location = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SkyBackground(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  AnimatedOpacity(
                    opacity: showLogo ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 1400),
                    curve: Curves.easeOutCubic,
                    child: AnimatedSlide(
                      offset: showLogo
                          ? Offset.zero
                          : const Offset(0, 0.08),
                      duration: const Duration(milliseconds: 1400),
                      curve: Curves.easeOutCubic,
                      child: IgnorePointer(
                        ignoring: widget.playIntro && !_introComplete,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,

                              MaterialPageRoute(
                                builder: (context) => const SkyTrailsApp(),
                              ),
                            );
                          },

                          child: Stack(
                            alignment: Alignment.center,

                            children: [
                              Container(
                                width: 230,

                                height: 120,

                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,

                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(
                                        0xFF5C8DFF,
                                      ).withValues(alpha: 0.12),

                                      blurRadius: 60,

                                      spreadRadius: 20,
                                    ),
                                  ],
                                ),
                              ),

                              AnimatedBuilder(
                                animation: _introController,
                                builder: (context, child) {
                                  final reveal = widget.playIntro
                                      ? Curves.easeOutCubic.transform(
                                          _introController.value,
                                        )
                                      : 1.0;
                                  return Opacity(
                                    opacity: reveal,
                                    child: Transform.scale(
                                      scale: 0.985 + (0.015 * reveal),
                                      child: child,
                                    ),
                                  );
                                },
                                child: Image.asset(
                                  'assets/images/sky_trails_logo.png',
                                  width: 320,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 5),

                  SizedBox(
                    width: 320,

                    height: 180,

                    child: Stack(
                      alignment: Alignment.centerLeft,

                      children: [
                        AnimatedOpacity(
                          opacity: showSearch ? 1.0 : 0.0,

                          duration: const Duration(milliseconds: 1400),

                          curve: Curves.easeOutCubic,

                          child: AnimatedSlide(
                            offset: showSearch
                                ? Offset.zero
                                : const Offset(0, 0.15),

                            duration: const Duration(milliseconds: 1400),

                            curve: Curves.easeOutCubic,

                            child: Container(
                              width: 310,

                              height: 52,

                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.28),

                                borderRadius: BorderRadius.circular(30),

                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.20),

                                  width: 1,
                                ),

                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xFF5C8DFF,
                                    ).withValues(alpha: 0.04),

                                    blurRadius: 30,

                                    spreadRadius: 2,

                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),

                              child: TextField(
                                textAlign: TextAlign.center,

                                decoration: InputDecoration(
                                  hintText: 'Coming Soon',

                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 18,
                                  ),

                                  hintStyle: TextStyle(
                                    color: Color(
                                      0xFF6FA8FF,
                                    ).withValues(alpha: 0.55),

                                    fontSize: 17,

                                    fontWeight: FontWeight.w300,

                                    letterSpacing: 0.4,
                                  ),

                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),

                        if (_introComplete)
                          Positioned(
                            left: 50,

                            top: 52,

                            child: AnimatedPlane(
                              onTap: () {
                                Future.delayed(
                                  const Duration(milliseconds: 1500),

                                  () {
                                    if (!mounted) return;

                                    setState(() {
                                      showSearch = true;
                                    });
                                  },
                                );
                              },
                            ),
                          )
                        else
                          Positioned.fill(
                            child: CinematicAircraft(
                              animation: CurvedAnimation(
                                parent: _introController,
                                curve: Curves.easeInOutCubic,
                              ),
                              start: const Offset(-100, 24),
                              controlA: const Offset(-8, 12),
                              controlB: const Offset(45, 78),
                              end: const Offset(76, 78),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              top: 50,

              right: 24,

              child: NotificationButton(
                onTap: () {
                  debugPrint("Notification tapped");
                },
              ),
            ),

            Positioned(
              bottom: 40,

              left: 0,

              right: 0,

              child: LocationDisplay(
                city: location?.city ?? "Loading",

                country: location?.country ?? "",
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _introController.dispose();
    super.dispose();
  }
}
