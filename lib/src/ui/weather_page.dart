import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_conditions_flutter/src/blocs/weather_bloc.dart';
import 'package:weather_conditions_flutter/src/models/day_weather.dart';
import 'package:weather_conditions_flutter/src/ui/city_search_delegate.dart';

class WeatherPage extends StatefulWidget {
  WeatherPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  @override
  void initState() {
    super.initState();
    bloc.fetchAllWeatherDataByCity('Cesena');
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final searchText = await showSearch(
                context: context,
                delegate: CitySearchDelegate(),
              );
              if (searchText != null ) bloc.fetchAllWeatherDataByCity(searchText);
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: bloc.allWeather,
        builder: (context, AsyncSnapshot<List<DayWeather>> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<List<DayWeather>> snapshot) {
    final dayWeatherList = snapshot.data;
    return ListView.builder(
      itemCount: dayWeatherList.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
            title: Text(DateFormat('EEEE dd MMMM').format(dayWeatherList[index].date)),
            subtitle: Text('${dayWeatherList[index].threeHourWeatherList[(dayWeatherList[index].threeHourWeatherList.length / 2).round() - 1].weatherDetails.description}\n'
                'Tmax: ${dayWeatherList[index].maxTemperature}, Tmin: ${dayWeatherList[index].minTemperature}'
            ),
            leading: Image.network('https://openweathermap.org/img/wn/'
                '${dayWeatherList[index].threeHourWeatherList[(dayWeatherList[index].threeHourWeatherList.length / 2).round() - 1].weatherDetails.icon}'
                '@4x.png'),
            isThreeLine: true,
          ),
        );
      },
    );
  }
}
