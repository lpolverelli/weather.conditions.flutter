import 'dart:math';

import 'package:weather_conditions_flutter/src/models/three_hour_weather.dart';

class DayWeather {
  final DateTime date;
  final List<ThreeHourWeather> threeHourWeatherList;
  double maxTemperature, minTemperature;

  DayWeather(this.date, this.threeHourWeatherList) {
    maxTemperature = threeHourWeatherList.map((threeHourWeather) => threeHourWeather.temperature).reduce(max);
    minTemperature = threeHourWeatherList.map((threeHourWeather) => threeHourWeather.temperature).reduce(min);
  }
}