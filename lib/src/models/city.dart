import 'package:weather_conditions_flutter/src/models/coordinates.dart';

class City {
  final int id, timezone;
  final String name, country;
  final Coordinates coordinates;

  City({this.id, this.name, this.coordinates, this.country, this.timezone});

  factory City.fromJson(Map<String, dynamic> json){
    return City(
      id: json['id'] as int,
      name: json['name'] as String,
      coordinates: Coordinates.fromJson(json['coord']),
      country: json['country'] as String,
      timezone: json['timezone'] as int
    );
  }
}