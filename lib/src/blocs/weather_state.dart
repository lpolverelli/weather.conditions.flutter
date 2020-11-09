import 'package:flutter/cupertino.dart';
import 'package:weather_conditions_flutter/src/models/day_weather.dart';

abstract class WeatherState {
  const WeatherState();
}

class WeatherInitial extends WeatherState {}

class WeatherLoadInProgress extends WeatherState {}

class WeatherLoadSuccess extends WeatherState {
  final List<DayWeather> weatherList;

  const WeatherLoadSuccess({@required this.weatherList}) : assert(weatherList != null);
}

class WeatherLoadFailure extends WeatherState {}