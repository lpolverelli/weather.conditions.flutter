import 'package:weather_conditions_flutter/src/models/weather_details.dart';

class ThreeHourWeather {
  final int hour;
  final double temperature;
  final WeatherDetails weatherDetails;

  ThreeHourWeather({this.hour, this.temperature, this.weatherDetails});

  factory ThreeHourWeather.fromJson(Map<String, dynamic> json) {
    return ThreeHourWeather(
      hour: DateTime.fromMicrosecondsSinceEpoch(json['dt'] * 1000000, isUtc: true).hour,
      temperature: json['main']['temp'],
      weatherDetails: WeatherDetails.fromJson(json['weather'].first.cast<String, dynamic>())
    );
  }
}