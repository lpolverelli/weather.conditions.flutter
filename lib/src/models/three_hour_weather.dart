import 'package:weather_conditions_flutter/src/models/weather_details.dart';

class ThreeHourWeather {
  final DateTime date;
  final double temperature;
  final WeatherDetails weatherDetails;

  ThreeHourWeather({this.date, this.temperature, this.weatherDetails});

  factory ThreeHourWeather.fromJson(Map<String, dynamic> json) {
    return ThreeHourWeather(
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: true),
      temperature: json['main']['temp'].toDouble(),
      weatherDetails: WeatherDetails.fromJson(json['weather'].first.cast<String, dynamic>())
    );
  }
}