import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_conditions_flutter/src/blocs/weather_bloc.dart';
import 'package:weather_conditions_flutter/src/blocs/weather_bloc_observer.dart';
import 'package:weather_conditions_flutter/src/resources/weather_repository.dart';
import 'package:weather_conditions_flutter/src/ui/weather_page.dart';

void main() {
  Bloc.observer = WeatherBlocObserver();

  final WeatherRepository weatherRepository = WeatherRepository();
  runApp(WeatherConditionsApp(weatherRepository: weatherRepository));
}

class WeatherConditionsApp extends StatelessWidget {
  final WeatherRepository weatherRepository;

  WeatherConditionsApp({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Conditions Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) =>
            WeatherBloc(weatherRepository: weatherRepository),
        child: WeatherPage(title: '5 Days Weather',),
      )
    );
  }
}