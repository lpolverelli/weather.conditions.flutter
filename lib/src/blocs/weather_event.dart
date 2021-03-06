import 'package:meta/meta.dart';

abstract class WeatherEvent {
  const WeatherEvent();
}

class WeatherRequested extends WeatherEvent {
  final String city;

  const WeatherRequested( {@required this.city} ) : assert(city != null);
}