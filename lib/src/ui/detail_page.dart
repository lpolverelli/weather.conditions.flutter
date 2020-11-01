import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_conditions_flutter/src/models/day_weather.dart';

class DetailPage extends StatelessWidget {

  final DayWeather dayWeather;

  DetailPage({Key key, @required this.dayWeather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Day Weather Details')
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: dayWeather.threeHourWeatherList.length,
        padding: const EdgeInsets.all(8),
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(DateFormat('Hm', 'it_IT').format(dayWeather.threeHourWeatherList[index].date)),
              subtitle: Text('${dayWeather.threeHourWeatherList[index].weatherDetails.description}\n'
                  'T: ${dayWeather.threeHourWeatherList[index].temperature}°C'
              ),
              leading: Image.network('https://openweathermap.org/img/wn/'
                  '${dayWeather.threeHourWeatherList[index].weatherDetails.icon}'
                  '@4x.png'),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}