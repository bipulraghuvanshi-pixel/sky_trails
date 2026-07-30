class Aircraft {
  final String callsign;
  final String country;
  final double distance;
  final double speed;
  final double? altitude;
  final double latitude;
  final double longitude;
  final double? heading;

  const Aircraft({
    required this.callsign,
    required this.country,
    required this.distance,
    required this.speed,
    required this.altitude,
    required this.latitude,
    required this.longitude,
    required this.heading,
  });
}