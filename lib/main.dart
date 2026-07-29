import 'landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
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
  double? userLat;
double? userLon;
Timer? refreshTimer;
List<Map<String, dynamic>> nearbyPlanes = [];

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

  Future<void> fetchAircraft() async {setState(() {
  lastUpdated = "Refreshing...";
});
  try {
    final response = await http.get(
      Uri.parse('https://opensky-network.org/api/states/all'),
    );

    print('Status Code: ${response.statusCode}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      print('Aircraft Found: ${data['states'].length}');

      final states = data['states'];
      nearbyPlanes.clear();
      int nearbyAircraft = 0;

      if (states != null) {
        for (final plane in states) {

          if (plane[5] == null || plane[6] == null) {
            continue;
          }

      if (userLat == null || userLon == null) {
  print("Location still null");
  return;
}

double distance = Geolocator.distanceBetween(
  userLat!,
  userLon!,
  (plane[6] as num).toDouble(),
  (plane[5] as num).toDouble(),
);

          if (distance <= 300000) {
            if (plane[1] == null ||
    plane[1].toString().trim().isEmpty) {
  continue;
}
            nearbyAircraft++;
 nearbyPlanes.add({
  'callsign': plane[1].toString().trim(),
  'country': plane[2],
  'altitude': plane[7],
  'speed': ((plane[9] ?? 0) * 3.6),
  'distance': distance / 1000,
  'latitude': plane[6],
'longitude': plane[5],
'heading': plane[10],
});print(nearbyPlanes);
            print('Nearby Plane: ${plane[1]}');
          }
        }

        print('Nearby Aircraft: $nearbyAircraft');
        print('Stored Planes: ${nearbyPlanes.length}');
        print('Stored Planes: ${nearbyPlanes.length}');
        nearbyPlanes.sort(
  (a, b) => a['distance'].compareTo(b['distance']),
);
        setState(() {
  final now = DateTime.now();

  lastUpdated =
      '${now.hour}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
});
      }
    }
  }  catch (e) {

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
      '✈ ${nearbyPlanes[index]['callsign']}',

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
  '🌍 ${nearbyPlanes[index]['country']}',
  style: TextStyle(
    color: retroMode
        ? Colors.greenAccent
        : Colors.black,
  ),
),
  

    

    Text(
  '📍 Distance: ${nearbyPlanes[index]['distance']?.toStringAsFixed(1) ?? '--'} km',
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
class AircraftDetailsPage extends StatelessWidget {
  final Map<String, dynamic> plane;
  final bool retroMode;

  const AircraftDetailsPage({
  super.key,
  required this.plane,
  required this.retroMode,
});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  backgroundColor:
    retroMode ? Colors.black : const Color(0xFFEAF3FF),
      appBar: AppBar(
  backgroundColor:
      retroMode ? Colors.black : null,

  iconTheme: IconThemeData(
    color: retroMode
        ? Colors.greenAccent
        : Colors.black,
  ),

  title: Text(
    'Aircraft Details',
    style: TextStyle(
      color: retroMode
          ? Colors.greenAccent
          : Colors.black,
    ),
  ),
),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
  '✈ ${plane['callsign']}',
  style: TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: retroMode
        ? Colors.greenAccent
        : Colors.black,

    shadows: retroMode
        ? [
            Shadow(
              color: Colors.greenAccent,
              blurRadius: 25,
            ),
          ]
        : [],
  ),
),

            const SizedBox(height: 20),

            Text(

  '🌍 ${plane['country']}',

  style: TextStyle(

    color: retroMode

        ? Colors.greenAccent

        : Colors.black,

  ),

),
Container(
  margin: const EdgeInsets.only(top: 20),
  padding: const EdgeInsets.all(16),
 decoration: BoxDecoration(
  border: Border.all(
    color: retroMode
        ? Colors.greenAccent
        : Colors.black26,
    width: 1,
  ),
),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

    Text(
  'CALL : ${plane['callsign']}',
  style: TextStyle(
    color: retroMode
        ? Colors.greenAccent
        : Colors.black87,
    fontSize: 18,
  ),
),

      const SizedBox(height: 8),

      Text(
        'CNTR : ${plane['country']}',
       style: TextStyle(
  color: retroMode
      ? Colors.greenAccent
      : Colors.black87,
  fontSize: 18,
),
      ),

      const SizedBox(height: 8),

     Text(
  'ALT  : ${plane['altitude']?.toStringAsFixed(0) ?? '--'} M',
  style: TextStyle(
    color: retroMode
        ? Colors.greenAccent
        : Colors.black87,
    fontSize: 18,
  ),
),

      const SizedBox(height: 8),

      Text(
        'SPD  : ${plane['speed'].toStringAsFixed(0)} KM/H',
       style: TextStyle(
  color: retroMode
      ? Colors.greenAccent
      : Colors.black87,
  fontSize: 18,
),
      ),

      const SizedBox(height: 8),

      Text(
        'DST  : ${plane['distance'].toStringAsFixed(1)} KM',
        style: TextStyle(
  color: retroMode
      ? Colors.greenAccent
      : Colors.black87,
  fontSize: 18,
),
      ),

      const SizedBox(height: 8),

      Text(
        'LAT  : ${plane['latitude'].toStringAsFixed(4)}',
        style: TextStyle(
  color: retroMode
      ? Colors.greenAccent
      : Colors.black87,
  fontSize: 18,
),
      ),

      const SizedBox(height: 8),

      Text(
        'LON  : ${plane['longitude'].toStringAsFixed(4)}',
        style: TextStyle(
  color: retroMode
      ? Colors.greenAccent
      : Colors.black87,
  fontSize: 18,
),
      ),
    ],
  ),
),
           

          ],
        ),
      ),
    );
  }
}
class RadarPage extends StatelessWidget {
  final List<Map<String, dynamic>> nearbyPlanes;
  final double userLat;
  final double userLon;
  final bool retroMode;

  const RadarPage({
  super.key,
  required this.nearbyPlanes,
  required this.userLat,
  required this.userLon,
  required this.retroMode,
});

  @override
  Widget build(BuildContext context) {
    print('Planes received: ${nearbyPlanes.length}');
    return Scaffold(
  backgroundColor:
      retroMode ? Colors.black : Colors.white,
      appBar: AppBar(
  backgroundColor:
      retroMode ? Colors.black : null,

  iconTheme: IconThemeData(
    color: retroMode
        ? Colors.greenAccent
        : Colors.black,
  ),

  title: Text(
  'Radar (${nearbyPlanes.length})',
  style: TextStyle(
      color: retroMode
          ? Colors.greenAccent
          : Colors.black,
    ),
  ),
),
 body: Center(

   
        child: SizedBox(
    width: 350,
    height: 350,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
  child: Container(
    width: 2,
    height: 350,
    color: Colors.greenAccent.withValues(alpha: 0.3),
  ),
),

Positioned(
  child: Container(
    width: 350,
    height: 2,
    color: Colors.greenAccent.withValues(alpha: 0.3),
  ),
),
        Container(
  width: 230,
  height: 230,
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    border: Border.all(
      color: retroMode
    ? Colors.green
    : Colors.grey,
      width: 1,
    ),
  ),
),
Container(
  width: 290,
  height: 290,
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    border: Border.all(
  color: retroMode
      ? Colors.greenAccent
      : Colors.black12,
  width: 1,
),
  ),
),
        Container(
  width: 350,
  height: 350,
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    border: Border.all(
      color: Colors.greenAccent.withValues(alpha: 0.7),
      width: 3,
    ),
   
  ),
),
   ...nearbyPlanes.map((plane) {
    double latDiff =
    (plane['latitude'] as num).toDouble() - userLat;

double lonDiff =
    (plane['longitude'] as num).toDouble() - userLon;
  return Positioned(
  top: 175 - (latDiff * 40),
  left: 175 + (lonDiff * 40),
 child: InkWell(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AircraftDetailsPage(
          plane: plane,
          retroMode: retroMode,
        ),
      ),
    );
  },
  child: Column(
  mainAxisSize: MainAxisSize.min,
  children: [

    Text(
      plane['callsign'],
      style: TextStyle(
        color: retroMode
            ? Colors.greenAccent
            : Colors.black,
        fontSize: 8,
        fontWeight: FontWeight.bold,
      ),
    ),


 Container(
  decoration: BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: Colors.greenAccent,
        blurRadius: 12,
        spreadRadius: 2,
      ),
    ],
  ),
 child: Transform.rotate(
  angle: ((plane['heading'] ?? 0) * math.pi / 180),
  child: Icon(
    Icons.navigation,
    color: retroMode
        ? Colors.greenAccent
        : Colors.orange,
    size: 20,
  ),
),
),
  ],
),
 ),
   );
 }),
          
        

                    Container(
          width: 12,
          height: 12,
          decoration: const BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
        ),
      ],
    ),
  ),
),
    );
    
  }
}