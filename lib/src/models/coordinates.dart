class Coordinates {
  final double latitude, longitude;

  Coordinates({this.latitude, this.longitude});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      latitude: json['lat'] as double,
      longitude: json['lon'] as double
    );
  }
}