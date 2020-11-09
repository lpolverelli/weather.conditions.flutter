import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:weather_conditions_flutter/src/blocs/weather_bloc.dart';
import 'package:weather_conditions_flutter/src/blocs/weather_event.dart';
import 'package:weather_conditions_flutter/src/blocs/weather_state.dart';
import 'package:weather_conditions_flutter/src/models/day_weather.dart';
import 'package:weather_conditions_flutter/src/ui/city_search_delegate.dart';
import 'package:weather_conditions_flutter/src/ui/detail_page.dart';

class WeatherPage extends StatelessWidget {
  final String title;

  WeatherPage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final searchText = await showSearch(
                context: context,
                delegate: CitySearchDelegate(),
              );
              if (searchText != null ) BlocProvider.of<WeatherBloc>(context).add(WeatherRequested(city: searchText));
            },
          ),
        ],
      ),
      body: Center(
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherInitial) {
              return Center(
                child: Text('Please Select a Location'),
              );
            }
            if (state is WeatherLoadInProgress) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is WeatherLoadSuccess) {
              final weatherList = state.weatherList;

              return buildList(weatherList);
            }
            if (state is WeatherLoadFailure) {
              return Text(
                'Something went wrong!',
                style: TextStyle(color: Colors.red),
              );
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget buildList(List<DayWeather> dayWeatherList) {
    initializeDateFormatting('it_IT');
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: AutoSizeText(
                '${dayWeatherList.first.city.name}, ${dayWeatherList.first.city.country}',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                maxLines: 2
            ),
          ),
        ),
        Expanded(
            flex: 4,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: dayWeatherList.length,
              padding: const EdgeInsets.all(8),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    title: Text(DateFormat('EEEE dd MMMM', 'it_IT').format(dayWeatherList[index].date)),
                    subtitle: Text('${dayWeatherList[index].threeHourWeatherList[(dayWeatherList[index].threeHourWeatherList.length / 2).round() - 1].weatherDetails.description}\n'
                        'Tmax: ${dayWeatherList[index].maxTemperature}°C - Tmin: ${dayWeatherList[index].minTemperature}°C'
                    ),
                    leading: Image.network('https://openweathermap.org/img/wn/'
                        '${dayWeatherList[index].threeHourWeatherList[(dayWeatherList[index].threeHourWeatherList.length / 2).round() - 1].weatherDetails.icon}'
                        '@4x.png'),
                    isThreeLine: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailPage(dayWeather: dayWeatherList[index])
                        ),
                      );
                    },
                  ),
                );
              },
            )
        ),
      ],
    );
  }

}
/*
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
      body: BlocBuilder<Bloc, BlocState>(
        builder: (context, state) {
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
    initializeDateFormatting('it_IT');
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: AutoSizeText(
              '${dayWeatherList.first.city.name}, ${dayWeatherList.first.city.country}',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              maxLines: 2
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: dayWeatherList.length,
            padding: const EdgeInsets.all(8),
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  title: Text(DateFormat('EEEE dd MMMM', 'it_IT').format(dayWeatherList[index].date)),
                  subtitle: Text('${dayWeatherList[index].threeHourWeatherList[(dayWeatherList[index].threeHourWeatherList.length / 2).round() - 1].weatherDetails.description}\n'
                      'Tmax: ${dayWeatherList[index].maxTemperature}°C - Tmin: ${dayWeatherList[index].minTemperature}°C'
                  ),
                  leading: Image.network('https://openweathermap.org/img/wn/'
                      '${dayWeatherList[index].threeHourWeatherList[(dayWeatherList[index].threeHourWeatherList.length / 2).round() - 1].weatherDetails.icon}'
                      '@4x.png'),
                  isThreeLine: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(dayWeather: dayWeatherList[index])
                      ),
                    );
                  },
                ),
              );
            },
          )
        ),
      ],
    );
  }
}
*/