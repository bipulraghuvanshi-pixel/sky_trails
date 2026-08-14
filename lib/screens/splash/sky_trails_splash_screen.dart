import 'package:flutter/material.dart';

import '../../landing_screen.dart';
import '../../widgets/clouds/sky_cloud_layer.dart';
import '../../widgets/cinematic_aircraft.dart';

class SkyTrailsSplashScreen extends StatefulWidget {
  const SkyTrailsSplashScreen({super.key});

  @override
  State<SkyTrailsSplashScreen> createState() => _SkyTrailsSplashScreenState();
}

class _SkyTrailsSplashScreenState extends State<SkyTrailsSplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..forward();

    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,

        MaterialPageRoute(builder: (_) => const LandingScreen(playIntro: true)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,

            end: Alignment.bottomCenter,

            colors: [
              Color(0xFFFFFFFF),

              Color(0xFFF4FAFF),

              Color(0xFFEAF5FF),

              Color(0xFFDDEEFF),
            ],
          ),
        ),

        child: SafeArea(
          child: Stack(
            children: [
              SkyCloudLayer(),

              LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  final height = constraints.maxHeight;
                  return Stack(
                    children: [
                      // A restrained landing reference, aligned to the landing search bar.
                      Positioned(
                        left: (width - 310) / 2,
                        top: height / 2 + 66,
                        child: Container(
                          width: 310,
                          height: 2,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.28),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      CinematicAircraft(
                        animation: CurvedAnimation(
                          parent: _controller,
                          curve: const Interval(
                            0.03,
                            0.64,
                            curve: Curves.easeInOutCubic,
                          ),
                        ),
                        start: Offset(-100, height * .36),
                        controlA: Offset(width * .20, height * .19),
                        controlB: Offset(width * .66, height * .23),
                        end: Offset(width + 90, height * .31),
                      ),
                      CinematicAircraft(
                        animation: CurvedAnimation(
                          parent: _controller,
                          curve: const Interval(
                            0.19,
                            0.79,
                            curve: Curves.easeInOutCubic,
                          ),
                        ),
                        start: Offset(-90, height * .56),
                        controlA: Offset(width * .24, height * .42),
                        controlB: Offset(width * .70, height * .64),
                        end: Offset(width + 100, height * .48),
                      ),
                      CinematicAircraft(
                        animation: CurvedAnimation(
                          parent: _controller,
                          curve: const Interval(
                            0.39,
                            0.97,
                            curve: Curves.easeInOutCubic,
                          ),
                        ),
                        start: Offset(-110, height * .28),
                        controlA: Offset(width * .28, height * .38),
                        controlB: Offset(width * .68, height * .47),
                        end: Offset(width + 95, height * .60),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
