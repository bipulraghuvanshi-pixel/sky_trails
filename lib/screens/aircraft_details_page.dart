import 'package:flutter/material.dart';
import '../models/aircraft.dart';

const testAircraftDetails = "OK";

class AircraftDetailsPage extends StatelessWidget {
  final Aircraft plane;
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
        backgroundColor: retroMode ? Colors.black : null,
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
              '✈ ${plane.callsign}',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: retroMode
                    ? Colors.greenAccent
                    : Colors.black,
                shadows: retroMode
                    ? const [
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
              '🌍 ${plane.country}',
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
                    'CALL : ${plane.callsign}',
                    style: TextStyle(
                      color: retroMode
                          ? Colors.greenAccent
                          : Colors.black87,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'CNTR : ${plane.country}',
                    style: TextStyle(
                      color: retroMode
                          ? Colors.greenAccent
                          : Colors.black87,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'ALT  : ${plane.altitude?.toStringAsFixed(0) ?? '--'} M',
                    style: TextStyle(
                      color: retroMode
                          ? Colors.greenAccent
                          : Colors.black87,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'SPD  : ${plane.speed.toStringAsFixed(0)} KM/H',
                    style: TextStyle(
                      color: retroMode
                          ? Colors.greenAccent
                          : Colors.black87,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'DST  : ${plane.distance.toStringAsFixed(1)} KM',
                    style: TextStyle(
                      color: retroMode
                          ? Colors.greenAccent
                          : Colors.black87,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'LAT  : ${plane.latitude.toStringAsFixed(4)}',
                    style: TextStyle(
                      color: retroMode
                          ? Colors.greenAccent
                          : Colors.black87,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'LON  : ${plane.longitude.toStringAsFixed(4)}',
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