import 'package:weather_conditions_flutter/src/models/weather_details.dart';

class ThreeHourWeather {
  int hour;
  double temperature;
  WeatherDetails weatherDetails;
  ThreeHourWeather(this.hour, this.temperature, this.weatherDetails);
}