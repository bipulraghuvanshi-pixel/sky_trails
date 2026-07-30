import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import '../models/aircraft.dart';

class AircraftService {
  const AircraftService();

  Future<List<dynamic>> fetchOpenSkyStates() async {
    final response = await http.get(
      Uri.parse('https://opensky-network.org/api/states/all'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch aircraft');
    }

    final data = jsonDecode(response.body);
    return data['states'] ?? [];
  }

  List<Aircraft> filterNearbyAircraft(
    List<dynamic> states,
    double userLat,
    double userLon,
  ) {
    final nearbyPlanes = <Aircraft>[];

    for (final plane in states) {
      if (plane[5] == null || plane[6] == null) {
        continue;
      }

      final double distance = Geolocator.distanceBetween(
        userLat,
        userLon,
        (plane[6] as num).toDouble(),
        (plane[5] as num).toDouble(),
      );

      if (distance > 300000) {
        continue;
      }

      if (plane[1] == null ||
          plane[1].toString().trim().isEmpty) {
        continue;
      }

      nearbyPlanes.add(
  Aircraft(
    callsign: plane[1].toString().trim(),
    country: plane[2] ?? '',
    altitude: (plane[7] as num?)?.toDouble(),
    speed: ((plane[9] ?? 0) as num).toDouble() * 3.6,
    distance: distance / 1000,
    latitude: (plane[6] as num).toDouble(),
    longitude: (plane[5] as num).toDouble(),
    heading: (plane[10] as num?)?.toDouble(),
  ),
);
    }

    nearbyPlanes.sort(
  (a, b) => a.distance.compareTo(b.distance),
);
    return nearbyPlanes;
  }
}