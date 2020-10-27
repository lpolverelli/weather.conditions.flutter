import 'package:weather_conditions_flutter/src/models/city.dart';
import 'package:weather_conditions_flutter/src/models/three_hour_weather.dart';

class DayWeather {
  City city;
  DateTime date;
  double maxTemperature, minTemperature;
  List<ThreeHourWeather> threeHourWeatherList;
  DayWeather(this.city, this.date, this.maxTemperature, this.minTemperature, this.threeHourWeatherList);
}