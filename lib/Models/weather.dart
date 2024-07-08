class Weather {
  final String city;
  final double temp;
  final double mintemp;
  final double maxtemp;

  Weather({
    required this.city,
    required this.temp,
    required this.mintemp,
    required this.maxtemp,
  });

  factory Weather.json(Map<String, dynamic> json) {
    return Weather(
      city: json['name'],
      temp: json["main"]['temp'],
      mintemp: json['main']["temp_min"],
      maxtemp: json['main']["temp_min"],
    );
  }
}
