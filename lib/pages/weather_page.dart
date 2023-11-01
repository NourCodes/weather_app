import 'dart:ui';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/Components/extra_info.dart';
import 'package:lottie/lottie.dart';
import '../weather_provider/provider.dart';
import 'loading_page.dart';
import 'package:provider/provider.dart';

class WeatherPage extends StatelessWidget {
  WeatherPage({super.key});

  getImage(String? condition) {
    //default is sunny
    if (condition == null) {
      return "assets/sunny.json";
    }

    switch (condition.toLowerCase()) {
      case "clouds":
        return "assets/cloudy.json";
      case "rain":
      case "thunderstorm":
        return "assets/rain.json";

      case "drizzle":
      case "shower rain":
        return "assets/partialrain.json";
      case "snow":
        return "assets/snow.json";

      default:
        return "assets/sunny.json";
    }
  }

  TextEditingController text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, value, child) {
        if (value.weather == null && value.hourlyWeather == null) {
          // Initially fetch weather for current city
          //Once the data is obtained, the app can then display the updated information,
          // replacing the loading screen with the actual content
          value.fetchWeatherForCurrentCity();
          return const LoadingPage();
        } else {
          return Scaffold(
            backgroundColor: Colors.black,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: AnimSearchBar(
                    helpText: "Select Your City",
                    searchIconColor: Colors.black,
                    color: Colors.deepPurpleAccent,
                    textFieldColor: Colors.white,
                    width: 350,
                    textController: text,
                    onSuffixTap: () {
                      text.clear();
                    },
                    // Inside the onSubmitted function of the city search bar
                    onSubmitted: (String city) {
                      value.fetchWeatherForCity(city);
                    }),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarBrightness: Brightness.dark,
              ),
            ),
            body: Padding(
              padding:
                  const EdgeInsets.fromLTRB(40, 1 * kToolbarHeight, 40, 20),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Align(
                      alignment: const AlignmentDirectional(3, -0.3),
                      child: Container(
                        height: 250,
                        width: 250,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(-3, -0.3),
                      child: Container(
                        height: 250,
                        width: 250,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(0, -1.2),
                      child: Container(
                        height: 250,
                        width: 250,
                        decoration: const BoxDecoration(
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                    ),
                    BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 100.0,
                        sigmaY: 80.0,
                      ),
                      child: Container(
                        decoration:
                            const BoxDecoration(color: Colors.transparent),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text(
                                value.weather?.city ?? "Loading.....",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            Lottie.asset(getImage(value.weather?.condition),
                                height: 250),
                            Text(
                              "${value.weather?.temperature.round()}°C",
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 40,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "${value.weather?.condition}",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              DateFormat().add_MMMEd().format(
                                  value.weather?.date ?? DateTime.now()),
                              style: const TextStyle(
                                color: Colors.white38,
                                fontSize: 10,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Divider(
                              color: Colors.white,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            // Additional Information
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ExtraInfo(
                                  value: "${value.weather?.wind.round()} km/h",
                                  icons: Icons.air,
                                  texts: "Wind",
                                ),
                                ExtraInfo(
                                    value:
                                        "${value.weather?.humidity.round()} %",
                                    icons: Icons.water_drop,
                                    texts: "Humidity"),
                                ExtraInfo(
                                  value: "${value.weather?.pressure.round()}",
                                  icons: Icons.beach_access,
                                  texts: "Pressure",
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            //hourly weather
                            SizedBox(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 8,
                                itemBuilder: (context, index) {
                                  return Card(
                                    color: Colors.black87,
                                    elevation: 1,
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        children: [
                                          Text(
                                              "${value.hourlyWeather?[index].temperature.round()}°C",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15)),
                                          Expanded(
                                            child: Container(
                                              child: Lottie.asset(getImage(value
                                                      .hourlyWeather?[index]
                                                      .condition ??
                                                  "")),
                                            ),
                                          ),
                                          Text(
                                              DateFormat("h:mm aa").format(value
                                                      .hourlyWeather?[index]
                                                      .hour ??
                                                  DateTime.now()),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15)),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
