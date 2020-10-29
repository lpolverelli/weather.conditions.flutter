import 'package:test/test.dart';
import 'package:weather_conditions_flutter/src/models/city.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_conditions_flutter/src/models/day_weather.dart';
import 'package:weather_conditions_flutter/src/models/three_hour_weather.dart';

class MockCity extends Mock implements City {}
class MockThreeHourWeather extends Mock implements ThreeHourWeather {}

void main() {
  
  test('Day weather should be created and should calculate max and min temperatures accurately', () {

    final threeHourWeather1 = MockThreeHourWeather();
    final threeHourWeather2 = MockThreeHourWeather();
    final threeHourWeather3 = MockThreeHourWeather();

    when(threeHourWeather1.temperature).thenReturn(285.3);
    when(threeHourWeather2.temperature).thenReturn(286.2);
    when(threeHourWeather3.temperature).thenReturn(287.6);

    final date = DateTime.fromMicrosecondsSinceEpoch(1603897200 * 1000000, isUtc: true);

    final city = MockCity();

    when(city.name).thenReturn('London');

    final threeHourWeatherList = [threeHourWeather1, threeHourWeather2, threeHourWeather3];
    final dayWeather = DayWeather(city, date, threeHourWeatherList);

    expect(dayWeather.city.name, 'London');
    expect(dayWeather.date, date);
    expect(dayWeather.maxTemperature, threeHourWeather3.temperature);
    expect(dayWeather.minTemperature, threeHourWeather1.temperature);
  });
}