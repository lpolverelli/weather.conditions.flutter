import 'dart:convert';

import 'package:test/test.dart';
import 'package:weather_conditions_flutter/src/models/coordinates.dart';

void main() {
  
  test('Coordinates should be decoded from json', () {
    final json =
        '{ '
          '"lat": 34.257, '
          '"lon": -85.1647 '
        '}';

    var coordinates = Coordinates.fromJson(jsonDecode(json).cast<String, dynamic>());

    expect(coordinates.latitude, 34.257);
    expect(coordinates.longitude, -85.1647);
  });
}

