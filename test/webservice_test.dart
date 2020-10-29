import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';
import 'package:weather_conditions_flutter/src/models/coordinates.dart';
import 'package:weather_conditions_flutter/src/models/day_weather.dart';
import 'package:weather_conditions_flutter/src/network/webservice.dart';

class MockClient extends Mock implements http.Client {}

main() {

  final url = 'api.openweathermap.org/data/2.5/forecast?';
  final city = 'Rome';
  final client = MockClient();
  final coordinates = Coordinates(latitude: 34.257, longitude: -85.1647);
  final json =
    '{'
      '"cod": "200",'
      '"message": 0,'
      '"cnt": 40,'
      '"list": ['
        '{'
          '"dt": 1603810800,'
          '"main": {'
           '"temp": 293.14'
          '},'
          '"weather": ['
            '{'
              '"id": 803,'
              '"main": "Clouds",'
              '"description": "broken clouds",'
              '"icon": "04d"'
            '}'
          ']'
        '},'
        '{'
          '"dt": 1603821600,'
          '"main": {'
            '"temp": 295.42'
          '},'
          '"weather": ['
            '{'
              '"id": 803,'
              '"main": "Clouds",'
              '"description": "broken clouds",'
              '"icon": "04d"'
            '}'
          ']'
        '},'
        '{'
          '"dt": 1604210400,'
          '"main": {'
            '"temp": 285.3'
          '},'
          '"weather": ['
            '{'
              '"id": 804,'
              '"main": "Clouds",'
              '"description": "overcast clouds",'
              '"icon": "04n"'
            '}'
          ']'
        '},'
        '{'
          '"dt": 1604221200,'
          '"main": {'
           '"temp": 284.89'
          '},'
          '"weather": ['
            '{'
              '"id": 804,'
              '"main": "Clouds",'
              '"description": "overcast clouds",'
              '"icon": "04n"'
            '}'
          ']'
        '},'
        '{'
          '"dt": 1604232000,'
          '"main": {'
            '"temp": 283.91'
          '},'
          '"weather": ['
            '{'
              '"id": 804,'
              '"main": "Clouds",'
              '"description": "overcast clouds",'
              '"icon": "04n"'
            '}'
          ']'
        '}'
      '],'
      '"city": {'
        '"id": 4219762,'
        '"name": "Rome",'
        '"coord": {'
          '"lat": 34.257,'
          '"lon": -85.1647'
        '},'
        '"country": "US"'
      '}'
    '}';

  group('Fetch test', () {

    test('Given in input a city, returns a string if the http call completes successfully', () async {

      when(client.get('${url}q=$city&appid=')).thenAnswer((_) async => http.Response(json, 200));

      final result = await fetchWeatherDataByCity(city, client);

      expect(result, isA<List<DayWeather>>());
      expect(result.length, 2);
    });

    test('Given in input a city, throws an exception if the http call completes with an error', () {

      when(client.get('${url}q=$city&appid=')).thenAnswer((_) async => http.Response('Not found', 404));

      expect(fetchWeatherDataByCity(city, client), throwsException);
    });

    test('Given in input a position, returns a string if the http call completes successfully', () async {

      when(client.get('${url}lat=${coordinates.latitude}&lon=${coordinates.longitude}&appid=')).thenAnswer((_) async => http.Response(json, 200));

      final result = await fetchWeatherDataByPosition(coordinates, client);

      expect(result, isA<List<DayWeather>>());
      expect(result.length, 2);
    });

    test('Given in input a position, throws an exception if the http call completes with an error', () {

      when(client.get('${url}lat=${coordinates.latitude}&lon=${coordinates.longitude}&appid=')).thenAnswer((_) async => http.Response('Not found', 404));

      expect(fetchWeatherDataByPosition(coordinates, client), throwsException);
    });

  });
}