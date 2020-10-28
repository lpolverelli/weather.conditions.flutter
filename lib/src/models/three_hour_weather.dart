import 'dart:convert';

import 'package:weather_conditions_flutter/src/models/weather_details.dart';

class ThreeHourWeather {
  final int hour;
  final double temperature;
  final WeatherDetails weatherDetails;

  ThreeHourWeather({this.hour, this.temperature, this.weatherDetails});

  factory ThreeHourWeather.fromJson(Map<String, dynamic> json) {
    return ThreeHourWeather(
      hour: DateTime.fromMicrosecondsSinceEpoch(int.parse(json['dt']), isUtc: true).hour,
      temperature: jsonDecode(json['main']).cast<Map<String, dynamic>>()['temp'],
      weatherDetails: WeatherDetails.fromJson(jsonDecode(json['weather']).cast<Map<String, dynamic>>())
    );
  }
}