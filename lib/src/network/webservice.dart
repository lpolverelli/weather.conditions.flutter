import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_conditions_flutter/src/models/city.dart';
import 'package:weather_conditions_flutter/src/models/coordinates.dart';
import 'package:weather_conditions_flutter/src/models/day_weather.dart';
import 'package:weather_conditions_flutter/src/models/three_hour_weather.dart';

final _url = 'https://api.openweathermap.org/data/2.5/forecast?';
final _apiKey = '9a93636936ed5af65de0ed174c0c9161';

Future<List<DayWeather>> fetchWeatherDataByCity(String city, http.Client client) async {
  final responseBody = await _fetchData('${_url}q=$city&appid=$_apiKey', client);

  return _parseDayWeather(responseBody);
}

Future<List<DayWeather>> fetchWeatherDataByPosition(Coordinates coordinates, http.Client client) async {
  final responseBody = await _fetchData('${_url}lat=${coordinates.latitude}&lon=${coordinates.longitude}&appid=$_apiKey', client);

  return _parseDayWeather(responseBody);
}

Future<String> _fetchData(String url, http.Client client) async {
  final response = await client.get(url);

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to get the resources');
  }
}

List<DayWeather> _parseDayWeather(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<String, dynamic>();
  final city = City.fromJson(parsed['city']);
  final list = parsed['list'];
  var threeHourWeatherList = list.map<ThreeHourWeather>((json) => ThreeHourWeather.fromJson(json)).toList();
  threeHourWeatherList.sort((ThreeHourWeather a, ThreeHourWeather b) => a.date.millisecondsSinceEpoch.compareTo(b.date.millisecondsSinceEpoch));
  final groupedThreeHourWeatherList = _groupThreeHourWeatherByDate(threeHourWeatherList);
  var dayWeatherList = List<DayWeather>();
  for(var element in groupedThreeHourWeatherList){
    dayWeatherList.add(DayWeather(city, element.first.date, element));
  }

  return dayWeatherList;
}

List<List<ThreeHourWeather>> _groupThreeHourWeatherByDate(List<ThreeHourWeather> threeHourWeatherList){
  var result = List<List<ThreeHourWeather>>();
  var currentDate = threeHourWeatherList.first.date;
  var currentDayList = List<ThreeHourWeather>();

  for(var element in threeHourWeatherList){
    if(element.date.year > currentDate.year ||
        element.date.month > currentDate.month ||
        element.date.day > currentDate.day){
      result.add(List<ThreeHourWeather>.from(currentDayList));
      currentDate = element.date;
      currentDayList.clear();
    }
    currentDayList.add(element);
  }
  result.add(List<ThreeHourWeather>.from(currentDayList));

  return result;
}