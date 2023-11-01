class WeatherModel {
  final String condition;
  final String city;
  final double temperature;
  final double humidity;
  final double pressure;
  final DateTime date;
  final double wind;

  WeatherModel(
      {required this.temperature,
      required this.condition,
      required this.city,
      required this.date,
      required this.humidity,
      required this.pressure,
      required this.wind});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['name'],
      condition: json['weather'][0]['main'],
      temperature: json['main']['temp'].toDouble(),
      humidity: json['main']['humidity'].toDouble(),
      pressure: json['main']['pressure'].toDouble(),
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      wind: json['wind']['speed'].toDouble(),
    );
  }
}
