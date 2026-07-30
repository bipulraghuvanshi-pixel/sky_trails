import 'landing_screen.dart';
import 'screens/aircraft_details_page.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'screens/radar_page.dart';
import 'services/aircraft_service.dart';
import 'models/aircraft.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LandingScreen(),
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

    print('Aircraft Found: ${states.length}');

    nearbyPlanes = aircraftService.filterNearbyAircraft(
      states,
      userLat!,
      userLon!,
    );

    print('Nearby Aircraft: ${nearbyPlanes.length}');
    print('Stored Planes: ${nearbyPlanes.length}');

    setState(() {
      final now = DateTime.now();

      lastUpdated =
          '${now.hour}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
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
      retroMode ? Colors.black : null,

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
    color: retroMode ? Colors.black : null,
    image: retroMode
        ? null
        : const DecorationImage(
            image: AssetImage(
              'assets/images/sky_background.png',
            ),
            fit: BoxFit.cover,
          ),
  ),
  child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
    fontSize: 24,
    color: retroMode
        ? Colors.greenAccent
        : Colors.black,
  ),
),
           

                SizedBox(height: 5),

                const Text(
                  'Within 300 km radius',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 4),

                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.circle,
                      size: 8,
                      color: Colors.green,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Live',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
const SizedBox(height: 4),

Text(
  'Last Updated: $lastUpdated',
  style: const TextStyle(
    fontSize: 12,
    color: Colors.grey,
  ),
),
                const SizedBox(height: 30),
                

Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [

    IconButton(
     onPressed: () {
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
      builder: (context) => RadarPage(
        nearbyPlanes: nearbyPlanes,
        userLat: userLat!,
        userLon: userLon!,
        retroMode: retroMode,
      ),
    ),
  );
},
      icon: Icon(
        Icons.radar,
        size: 64,
        color: retroMode
            ? Colors.greenAccent
            : Colors.black,
      ),
    ),

    const SizedBox(width: 20),

    IconButton(
      onPressed: () async {
        await fetchAircraft();
      },
      icon: Icon(
        Icons.refresh,
        size: 40,
        color: retroMode
            ? Colors.greenAccent
            : Colors.blue,
      ),
    ),

  ],
),

const SizedBox(height: 20),
                ListView.builder(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  itemCount: nearbyPlanes.length,
  itemBuilder: (context, index) {
    return InkWell(
  onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => AircraftDetailsPage(
  plane: nearbyPlanes[index],
  retroMode: retroMode,
),
    ),
  );
},
child: Card(
  elevation: 0,
  color: retroMode
      ? const Color(0xFF101010)
      : Colors.white.withValues(alpha: 0.25),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
  children: [
    Text(
      '✈ ${nearbyPlanes[index].callsign}',

      style: TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,
  color: retroMode
      ? Colors.greenAccent
      : Colors.black,
),
    ),
        

    const SizedBox(height: 8),

    
Text(
  '🌍 ${nearbyPlanes[index].country}',
  style: TextStyle(
    color: retroMode
        ? Colors.greenAccent
        : Colors.black,
  ),
),
  

    

    Text(
  '📍 Distance: ${nearbyPlanes[index].distance.toStringAsFixed(1) ?? '--'} km',
  style: TextStyle(
    color: retroMode
        ? Colors.greenAccent
        : Colors.black,
  ),
),
  ],
),
      ),
  ),
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

