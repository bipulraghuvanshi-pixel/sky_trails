import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widgets/aircraft/empty_sky_card.dart';
import 'widgets/location/reference_footer.dart';
import 'widgets/aircraft/error_card.dart';

import 'models/aircraft.dart';
import 'screens/aircraft_details_page.dart';
import 'screens/radar_page.dart';
import 'services/aircraft_service.dart';
import 'widgets/actions/action_card.dart';
import 'widgets/aircraft/aircraft_card.dart';
import 'package:sky_trails/screens/splash/sky_trails_splash_screen.dart';
import 'services/location_service.dart';
import 'widgets/sky/sky_background.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SkyTrailsSplashScreen(),
    ),
  );
}

class SkyTrailsApp extends StatefulWidget {
  const SkyTrailsApp({super.key});

  @override
  State<SkyTrailsApp> createState() => _SkyTrailsAppState();
}

class _SkyTrailsAppState extends State<SkyTrailsApp> {
  String locationText = "Getting location...";
  String lastUpdated = "--";
  String? errorMessage;

  final AircraftService aircraftService = const AircraftService();
  final LocationService locationService = const LocationService();

  double? userLat;
  double? userLon;

  LocationData? location;

  Timer? refreshTimer;

  List<Aircraft> nearbyPlanes = [];

  @override
  void initState() {
    super.initState();

    loadData();

    refreshTimer = Timer.periodic(const Duration(minutes: 30), (timer) {
      fetchAircraft();
    });
  }

  @override
  void dispose() {
    refreshTimer?.cancel();
    super.dispose();
  }

  Future<void> loadData() async {
    await getLocation();
    await fetchAircraft();
  }

  Future<void> fetchAircraft() async {
    setState(() {
      lastUpdated = "Refreshing...";
      errorMessage = null;
    });

    try {
      if (userLat == null || userLon == null) {
        print("Location still null");
        return;
      }

      final states = await aircraftService.fetchOpenSkyStates();

      print("Aircraft Found: ${states.length}");

      nearbyPlanes = aircraftService.filterNearbyAircraft(
        states,
        userLat!,
        userLon!,
      );

      print("Nearby Aircraft: ${nearbyPlanes.length}");
      print("Stored Planes: ${nearbyPlanes.length}");

      setState(() {
        final now = DateTime.now();

        lastUpdated =
            "${now.hour}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
      });
    } catch (e) {
      String message;

      if (e.toString().contains("RADAR_BUSY")) {
        message =
            "The radar is busy right now.\n"
            "Aircraft data will return shortly.";
      } else if (e.toString().contains("NETWORK_ERROR")) {
        message =
            "Unable to reach aircraft radar.\n"
            "Check your internet connection.";
      } else {
        message =
            "Aircraft data is temporarily unavailable.\n"
            "Please try again shortly.";
      }

      setState(() {
        lastUpdated = "ERROR";

        errorMessage = message;
      });

      print("Error: $e");
    }
  }

  Future<void> getLocation() async {
    try {
      location = await locationService.getLocation();

      if (location != null) {
        userLat = location!.latitude;
        userLon = location!.longitude;
      }

      setState(() {});
    } catch (e) {
      print("LOCATION ERROR: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sky Trails',
      home: Scaffold(
        extendBodyBehindAppBar: true,

        backgroundColor: Colors.transparent,

        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,

            statusBarIconBrightness: Brightness.dark,
          ),

          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF6FA8FF)),

            onPressed: () {
              Navigator.pop(context);
            },
          ),

          backgroundColor: Colors.transparent,

          surfaceTintColor: Colors.transparent,

          elevation: 0,

          scrolledUnderElevation: 0,
        ),

        body: SkyBackground(
          child: Builder(
            builder: (context) {
              return Container(
                color: Colors.transparent,

                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,

                      children: [
                        const SizedBox(height: 2),
                        Transform.translate(
                          offset: const Offset(0, -20),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'OVER YOU',
                                      style: TextStyle(
                                        fontSize: 34,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 3.0,
                                        foreground: Paint()
                                          ..shader =
                                              const LinearGradient(
                                                colors: [
                                                  Color(0xFFB7D6FF),
                                                  Color(0xFF7BAEFF),
                                                  Color(0xFF3B82F6),
                                                ],
                                              ).createShader(
                                                const Rect.fromLTWH(
                                                  0,
                                                  0,
                                                  260,
                                                  0,
                                                ),
                                              ),
                                      ),
                                    ),

                                    TextSpan(
                                      text: '  ^',
                                      style: TextStyle(
                                        fontSize: 34,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF2563EB),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(width: 8),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Nearby Aircraft',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF294C7A),
                                ),
                              ),

                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),

                                decoration: BoxDecoration(
                                  color: const Color(0xFFEAF3FF),

                                  borderRadius: BorderRadius.circular(12),
                                ),

                                child: Text(
                                  '${nearbyPlanes.length}',

                                  style: const TextStyle(
                                    fontSize: 15,

                                    fontWeight: FontWeight.w700,

                                    color: Color(0xFF294C7A),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),

                              Row(
                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF34A853),
                                      shape: BoxShape.circle,
                                    ),
                                  ),

                                  const SizedBox(width: 4),

                                  const Text(
                                    'Live',
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: Color(0xFF6BBF7A),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 0),

                        Text(
                          '(within 300 km)',
                          style: const TextStyle(
                            fontSize: 9,
                            color: Color(0x8890B8E8),
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.8,
                          ),
                        ),

                        const SizedBox(height: 4),

                        // Restore the original visual separation before the
                        // Radar and Refresh controls.
                        const SizedBox(height: 30),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: ActionCard(
                                  icon: Icons.radar,
                                  title: 'Radar',
                                  subtitle: 'View on map',

                                  onTap: () {
                                    if (userLat == null || userLon == null) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Location not available yet',
                                          ),
                                        ),
                                      );
                                      return;
                                    }

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => RadarPage(
                                          nearbyPlanes: nearbyPlanes,
                                          userLat: userLat!,
                                          userLon: userLon!,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),

                              const SizedBox(width: 14),

                              Flexible(
                                child: ActionCard(
                                  icon: Icons.refresh_rounded,
                                  title: 'Refresh',
                                  subtitle: 'Update now',

                                  onTap: () async {
                                    await fetchAircraft();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 10),
                        Text(
                          'Updated • $lastUpdated',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF8FAFE8),
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        const SizedBox(height: 10),

                        if (errorMessage != null)
                          ErrorCard(
                            title:
                                errorMessage != null &&
                                    errorMessage!.contains("radar is busy")
                                ? "Sky data delayed"
                                : "Sky connection lost",

                            message:
                                errorMessage ??
                                "Unable to reach aircraft radar.",
                          )
                        else if (nearbyPlanes.isEmpty)
                          const EmptySkyCard()
                        else
                          ListView.builder(
                            shrinkWrap: true,

                            physics: const NeverScrollableScrollPhysics(),

                            itemCount: nearbyPlanes.length,

                            itemBuilder: (context, index) {
                              return AircraftCard(
                                plane: nearbyPlanes[index],

                                onTap: () {
                                  Navigator.push(
                                    context,

                                    MaterialPageRoute(
                                      builder: (_) => AircraftDetailsPage(
                                        plane: nearbyPlanes[index],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        const SizedBox(height: 50),

                        ReferenceFooter(location: location),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
