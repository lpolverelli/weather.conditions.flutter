class WeatherDetails {
  final int id;
  final String main, description, icon;

  WeatherDetails({this.id, this.main, this.description, this.icon});

  factory WeatherDetails.fromJson(Map<String, dynamic> json) {
    return WeatherDetails(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon']
    );
  }
}