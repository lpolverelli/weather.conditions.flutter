import 'package:http/http.dart' as http;

import 'package:weather_conditions_flutter/src/models/day_weather.dart';
import 'package:weather_conditions_flutter/src/network/webservice.dart';

class WeatherRepository {
  Future<List<DayWeather>> fetchAllWeatherDataByCity(String city) => fetchWeatherDataByCity(city, http.Client());
}