import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/models/hourly_temp.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherService {
  static const Url = "https://api.openweathermap.org/data/2.5/weather";
  //apikey
  String apikey = dotenv.env['API_KEY']!;

  //user can select a specific city or get weather of current city
  Future<WeatherModel> getWeather(String cityName) async {
    final response = await http
        .get(Uri.parse("$Url?q=$cityName&appid=$apikey&units=metric"));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("An Error Occurred");
    }
  }


// get current city location
  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    //get permission from user
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    //fetch current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    //convert location into a list of placemark objects
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    //extract city name from the first placemark
    String? city = placemarks[0].locality;

    return city ?? "";
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////Hourly Weather


  Future<List<HourlyWeather>> getHourlyWeather(String cityName) async {
    final response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=$apikey&units=metric"));

    if (response.statusCode == 200) {
      return HourlyWeather.listFromJson(jsonDecode(response.body));
    } else {
      throw Exception("An Error Occurred");
    }
  }
}
