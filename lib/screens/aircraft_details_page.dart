import 'package:flutter/material.dart';
import '../models/aircraft.dart';
import 'widgets/aircraft_detail_tile.dart';

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
          retroMode ? Colors.black : Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            retroMode ? Colors.black : Colors.white,
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
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),

            Text(
              '✈ ${plane.callsign}',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: retroMode
                    ? Colors.greenAccent
                    : Colors.black,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              '🌍 ${plane.country}',
              style: TextStyle(
                fontSize: 18,
                color: retroMode
                    ? Colors.greenAccent
                    : Colors.grey,
              ),
            ),

            const SizedBox(height: 24),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                children: [
                  AircraftDetailTile(
                    icon: Icons.sell_outlined,
                    title: 'CALL SIGN',
                    value: plane.callsign,
                    retroMode: retroMode,
                  
                  ),

                  AircraftDetailTile(
                    icon: Icons.flag_outlined,
                    title: 'COUNTRY',
                    value: plane.country,
                    retroMode: retroMode,
                  ),

                  AircraftDetailTile(
                    icon: Icons.flight_takeoff,
                    title: 'ALTITUDE',
                    value:
                        '${plane.altitude?.toStringAsFixed(0) ?? '--'} M',
                        retroMode: retroMode,
                  ),

                  AircraftDetailTile(
                    icon: Icons.speed,
                    title: 'SPEED',
                    value:
                        '${plane.speed.toStringAsFixed(0)} KM/H',
                        retroMode: retroMode,
                  ),

                  AircraftDetailTile(
                    icon: Icons.near_me_outlined,
                    title: 'DISTANCE',
                    value:
                        '${plane.distance.toStringAsFixed(1)} KM',
                        retroMode: retroMode,
                  ),

                  AircraftDetailTile(
                    icon: Icons.location_on_outlined,
                    title: 'LATITUDE',
                    value:
                        plane.latitude.toStringAsFixed(4),
                        retroMode: retroMode,
                  ),

                  AircraftDetailTile(
                    icon: Icons.public,
                    title: 'LONGITUDE',
                    value:
                        plane.longitude.toStringAsFixed(4),
                        retroMode: retroMode,
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}