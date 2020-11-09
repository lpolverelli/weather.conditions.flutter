import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_conditions_flutter/src/blocs/weather_event.dart';
import 'package:weather_conditions_flutter/src/blocs/weather_state.dart';
import 'package:weather_conditions_flutter/src/resources/weather_repository.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState>{
  final WeatherRepository weatherRepository;

  WeatherBloc({@required this.weatherRepository})
      : assert(weatherRepository != null),
      super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is WeatherRequested) {
      yield WeatherLoadInProgress();
      try {
        final weatherList = await weatherRepository.fetchAllWeatherDataByCity(event.city);
        yield WeatherLoadSuccess(weatherList: weatherList);
      } catch (_) {
        yield WeatherLoadFailure();
      }
    }
  }
}