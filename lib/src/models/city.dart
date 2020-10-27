import 'package:weather_conditions_flutter/src/models/coordinates.dart';

class City {
  int id, timezone;
  String name, country;
  Coordinates coordinates;
  City(this.id, this.name, this.coordinates, this.country, this.timezone);
}