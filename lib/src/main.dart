import 'package:flutter/material.dart';
import 'package:weather_conditions_flutter/src/ui/weather_page.dart';

void main() {
  runApp(WeatherConditionsApp());
}

class WeatherConditionsApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Conditions Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherPage(title: '5 Days Weather'),
    );
  }
}