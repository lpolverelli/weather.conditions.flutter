import 'dart:convert';

import 'package:test/test.dart';
import 'package:weather_conditions_flutter/src/models/city.dart';

void main() {

  test('City should be decoded from json', () {
    final json =
        '{ '
          '"id": 2643743,'
          '"name": "London",'
          '"coord": {'
            '"lat": 51.5073,'
            '"lon": -0.1277'
          '},'
          '"country": "GB",'
          '"timezone": 0,'
          '"sunrise": 1578384285,'
          '"sunset": 1578413272'
        '}';

    var city = City.fromJson(jsonDecode(json).cast<String, dynamic>());

    expect(city.id, 2643743);
    expect(city.name, 'London');
    expect(city.coordinates.latitude, 51.5073);
    expect(city.coordinates.longitude, -0.1277);
    expect(city.country, 'GB');
    expect(city.timezone, 0);
  });
}