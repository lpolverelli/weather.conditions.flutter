import 'package:rxdart/rxdart.dart';
import 'package:weather_conditions_flutter/src/models/day_weather.dart';
import 'package:weather_conditions_flutter/src/resources/weather_repository.dart';

class WeatherBloc{
  final _repository = WeatherRepository();
  final _weatherFetcher = PublishSubject<List<DayWeather>>();

  Observable<List<DayWeather>> get allWeather => _weatherFetcher.stream;

  fetchAllWeatherDataByCity(String city) async {
    List<DayWeather> dayWeatherList = await _repository.fetchAllWeatherDataByCity(city);
    _weatherFetcher.sink.add(dayWeatherList);
  }

  dispose() {
    _weatherFetcher.close();
  }

  final bloc = WeatherBloc();
}