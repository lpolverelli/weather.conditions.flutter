import 'dart:convert';

import 'package:test/test.dart';
import 'package:weather_conditions_flutter/src/models/weather_details.dart';

void main() {

  test('Weather details should be decoded from json', () {
    final json =
      '{'
        '"id": 804,'
        '"main": "Clouds",'
        '"description": "overcast clouds",'
        ' "icon": "04n"'
      '}';

    var weatherDetails = WeatherDetails.fromJson(jsonDecode(json).cast<String, dynamic>());

    expect(weatherDetails.id, 804);
    expect(weatherDetails.main, 'Clouds');
    expect(weatherDetails.description, 'overcast clouds');
    expect(weatherDetails.icon, '04n');
  });
}