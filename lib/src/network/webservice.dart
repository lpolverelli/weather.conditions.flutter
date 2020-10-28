import 'package:http/http.dart' as http;

class Webservice {

  final url = 'api.openweathermap.org/data/2.5/forecast?';
  final apiKey = '';

  Future<String> fetchWeatherDataByCity(String city, http.Client client) async {
    return _fetchData('${url}q=$city&appid=$apiKey', client);
  }

  Future<String> fetchWeatherDataByPosition(double latitude, double longitude, http.Client client) async {
    return _fetchData('${url}lat=$latitude&lon=$longitude&appid=$apiKey', client);
  }

  Future<String> _fetchData(String url, http.Client client) async {
    final response = await client.get(url);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to get the resources');
    }
  }
}