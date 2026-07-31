import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'models/aircraft.dart';
import 'screens/aircraft_details_page.dart';
import 'screens/radar_page.dart';
import 'services/aircraft_service.dart';
import 'widgets/actions/action_card.dart';
import 'widgets/aircraft/aircraft_card.dart';
import 'package:sky_trails/screens/splash/sky_trails_splash_screen.dart';

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
  bool retroMode = false;

  String locationText = "Getting location...";
  String lastUpdated = "--";

  final AircraftService aircraftService = const AircraftService();

  double? userLat;
  double? userLon;

  Timer? refreshTimer;

  List<Aircraft> nearbyPlanes = [];

  @override
  void initState() {
    super.initState();

    loadData();

    refreshTimer = Timer.periodic(
      const Duration(minutes: 30),
      (timer) {
        fetchAircraft();
      },
    );
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
      setState(() {
        lastUpdated = "ERROR";
      });

      print("Error: $e");
    }
  }

  Future<void> getLocation() async {
    try {
      print("Checking location...");

      LocationPermission permission =
          await Geolocator.checkPermission();

      print("Permission before request: $permission");

      permission = await Geolocator.requestPermission();

      print("Permission after request: $permission");

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      print("POSITION RECEIVED");
      print(position.latitude);
      print(position.longitude);

      userLat = position.latitude;
      userLon = position.longitude;

      print("User Lat: $userLat");
      print("User Lon: $userLon");

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
        backgroundColor:
            retroMode ? Colors.black : const Color(0xFFF4F8FC),

        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: retroMode
                  ? Colors.greenAccent
                  : Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),

          backgroundColor:
              retroMode ? Colors.black : Colors.white,

          surfaceTintColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,

          title: Text(
            'Sky Trails',
            style: TextStyle(
              color: retroMode
                  ? Colors.greenAccent
                  : Colors.black,
            ),
          ),
        ),

        body: Builder(
          builder: (context) {
            return Container(
              decoration: BoxDecoration(
                color: retroMode
                    ? Colors.black
                    : Colors.white,
              ),

              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,

                    children: [
                      const SizedBox(height: 70),

                      SizedBox(
                        width: 180,
                        height: 180,

                        child: Stack(
                          alignment: Alignment.center,

                          children: [
                                                        Container(
                              width: 180,
                              height: 180,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: retroMode
                                      ? Colors.greenAccent
                                      : Colors.blue.shade50,
                                  width: 2,
                                ),
                              ),
                            ),

                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: retroMode
                                      ? Colors.green
                                      : Colors.blue.shade200,
                                  width: 2,
                                ),
                              ),
                            ),

                            IconButton(
                              onPressed: () {
                                setState(() {
                                  retroMode = !retroMode;
                                });
                              },
                              icon: Icon(
                                retroMode
                                    ? Icons.flight
                                    : Icons.radar,
                                size: 40,
                                color: retroMode
                                    ? Colors.greenAccent
                                    : Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text(
                        'Over You',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.4,
                          color: retroMode
                              ? Colors.greenAccent
                              : Colors.black,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
  'Within 300 km radius',
  style: TextStyle(
    fontSize: 13,
    color: Colors.grey.shade600,
    letterSpacing: 0.2,
  ),
),

const SizedBox(height: 4),

Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    const Icon(
      Icons.circle,
      size: 9,
      color: Colors.green,
    ),

    const SizedBox(width: 4),

    const Text(
      'Live',
      style: TextStyle(
        fontSize: 11,
        color: Colors.green,
        fontWeight: FontWeight.w700,
      ),
    ),
  ],
),

const SizedBox(height: 4),

Text(
  'Updated • $lastUpdated',
  style: const TextStyle(
    fontSize: 12,
    color: Colors.grey,
  ),
),

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
          retroMode: retroMode,
          onTap: () {
            if (userLat == null || userLon == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Location not available yet'),
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
                  retroMode: retroMode,
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
          retroMode: retroMode,
          onTap: () async {
            await fetchAircraft();
          },
        ),
      ),
    ],
  ),
),

Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
       Text(
        'Nearby Aircraft',
        style: TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: retroMode
      ? Colors.greenAccent
      : const Color(0xFF0F172A),
),
      ),

      Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: retroMode
    ? const Color(0xFF18311E)
    : const Color(0xFFEAF3FF),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          '${nearbyPlanes.length}',
          style: TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.bold,
  color: retroMode
      ? Colors.greenAccent
      : const Color(0xFF2F80ED),
),
        ),
      ),
    ],
  ),
),

const SizedBox(height: 14),

                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: nearbyPlanes.length,
                        itemBuilder: (context, index) {
                          return AircraftCard(
  plane: nearbyPlanes[index],
  retroMode: retroMode,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AircraftDetailsPage(
          plane: nearbyPlanes[index],
          retroMode: retroMode,
        ),
      ),
    );
  },
);
                          
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}