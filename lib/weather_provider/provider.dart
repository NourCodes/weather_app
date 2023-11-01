import 'package:flutter/material.dart';
import 'package:weather_app/services/weather_service.dart';
import '../models/hourly_temp.dart';
import '../models/weather_model.dart';

class WeatherProvider with ChangeNotifier {
  WeatherModel? _weather;
  List<HourlyWeather>? _hourlyWeather;
  final _weatherService = WeatherService();

  WeatherModel? get weather => _weather;
  List<HourlyWeather>? get hourlyWeather => _hourlyWeather;

  // Fetch weather data for the city from the API here
  Future<void> fetchWeatherForCity(String city) async {
    try {
      //get weather for a specific city
      final weather = await _weatherService.getWeather(city);

      //get hourly weather for a specific city
      final hourlyWeather = await _weatherService.getHourlyWeather(city);

      _weather = weather;
      _hourlyWeather = hourlyWeather;
      // Update _weather & _hourlyWeather
      notifyListeners();
    } catch (e) {
      throw e.toString();
    }
  }

  // Fetch weather data for the current city using device location or default city
  Future<void> fetchWeatherForCurrentCity() async {
    //get current city
    String city = await _weatherService.getCurrentCity();
    //use the method above
    await fetchWeatherForCity(city);

  }
}
