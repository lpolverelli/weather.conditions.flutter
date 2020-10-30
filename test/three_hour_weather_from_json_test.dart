import 'dart:convert';

import 'package:test/test.dart';
import 'package:weather_conditions_flutter/src/models/three_hour_weather.dart';

void main() {

  test('Three hour weather should be decoded from json', () {
    final json =
        '{'
          '"dt": 1596564000,'
          '"main": {'
            '"temp": 293.55,'
            '"feels_like": 293.13,'
            '"temp_min": 293.55,'
            '"temp_max": 294.05,'
            '"pressure": 1013,'
            '"sea_level": 1013,'
            '"grnd_level": 976,'
            '"humidity": 84,'
            '"temp_kf": -0.5'
          '},'
          '"weather": ['
            '{'
              '"id": 500,'
              '"main": "Rain",'
              '"description": "light rain",'
              '"icon": "10d"'
            '}'
          '],'
          '"clouds": {'
            '"all": 38'
          '},'
          '"wind": {'
            '"speed": 4.35,'
            '"deg": 309'
          '},'
          '"visibility": 10000,'
          '"pop": 0.49,'
          '"rain": {'
            '"3h": 0.53'
          '},'
          '"sys": {'
            '"pod": "d"'
          '},'
          '"dt_txt": "2020-08-04 18:00:00"'
        '}';

    var threeHourWeather = ThreeHourWeather.fromJson(jsonDecode(json).cast<String, dynamic>());

    expect(threeHourWeather.date.millisecondsSinceEpoch, DateTime.fromMillisecondsSinceEpoch(1596564000 * 1000).millisecondsSinceEpoch);
    expect(threeHourWeather.temperature, 294);
    expect(threeHourWeather.weatherDetails.id, 500);
    expect(threeHourWeather.weatherDetails.main, 'Rain');
    expect(threeHourWeather.weatherDetails.description, 'light rain');
    expect(threeHourWeather.weatherDetails.icon, '10d');
  });
}