import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';
import 'package:weather_conditions_flutter/src/network/webservice.dart';

class MockClient extends Mock implements http.Client {}

main() {

  final url = 'api.openweathermap.org/data/2.5/forecast?';
  final city = 'London';
  final latitude = 34.257;
  final longitude = -85.1647;
  final webservice = Webservice();
  final client = MockClient();

  group('Fetch test', () {

    test('Given in input a city, returns a string if the http call completes successfully', () async {
      when(client.get('${url}q=$city&appid=')).thenAnswer((_) async => http.Response('{"test": "Test"}', 200));

      expect(await webservice.fetchWeatherDataByCity('London', client), isA<String>());
    });
    
    test('Given in input a city, throws an exception if the http call completes with an error', () {
      when(client.get('${url}q=$city&appid=')).thenAnswer((_) async => http.Response('Not found', 404));

      expect(webservice.fetchWeatherDataByCity('London', client), throwsException);
    });

    test('Given in input a position, returns a string if the http call completes successfully', () async {
      when(client.get('${url}lat=$latitude&lon=$longitude&appid=')).thenAnswer((_) async => http.Response('{"test": "Test"}', 200));

      expect(await webservice.fetchWeatherDataByPosition(latitude, longitude, client), isA<String>());
    });

    test('Given in input a position, throws an exception if the http call completes with an error', () {
      when(client.get('${url}lat=$latitude&lon=$longitude&appid=')).thenAnswer((_) async => http.Response('Not found', 404));

      expect(webservice.fetchWeatherDataByPosition(latitude, longitude, client), throwsException);
    });
    
  });
}