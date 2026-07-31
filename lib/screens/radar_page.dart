
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'aircraft_details_page.dart';
import '../models/aircraft.dart';




class RadarPage extends StatelessWidget {
  final List<Aircraft> nearbyPlanes;
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
  backgroundColor: retroMode
      ? Colors.black
      : Colors.white,

  surfaceTintColor: Colors.transparent,

  elevation: 0,

  scrolledUnderElevation: 0,

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
    double latDiff = plane.latitude - userLat;
double lonDiff = plane.longitude - userLon;
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
      plane.callsign,
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
  angle: ((plane.heading ?? 0) * math.pi / 180),
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