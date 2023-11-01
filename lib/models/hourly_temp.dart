class HourlyWeather {
  double temperature;
  String condition;
  DateTime hour;

  HourlyWeather({
    required this.temperature,
    required this.condition,
    required this.hour,
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    return HourlyWeather(
      hour: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      condition: json['weather'][0]['main'],
      temperature: json['main']['temp'].toDouble(),
    );
  }

  static List<HourlyWeather> listFromJson(Map<String, dynamic> json) {
    List<dynamic> hourlyDataList = json["list"];//the whole data will be stored here
    List<HourlyWeather> hourlyWeatherList = [];

    for (int i = 1; i < hourlyDataList.length; i++) {//start from 1 cause we are already displaying the first
      hourlyWeatherList.add(HourlyWeather.fromJson(hourlyDataList[i]));
    }

    return hourlyWeatherList;
  }
}
