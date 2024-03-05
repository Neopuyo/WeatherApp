import 'package:flutter/material.dart';
import 'package:weather_final_proj/models/weather_data.dart';
import 'package:weather_final_proj/providers/city_provider.dart';

class CurrentlyWeatherTab extends StatelessWidget {
  const CurrentlyWeatherTab({super.key, required this.cityProvider});

  final CityProvider cityProvider;

  @override
  Widget build(BuildContext context) {
    final WeatherData weatherData = cityProvider.weatherData;
    // Construisez l'interface utilisateur de l'onglet "Currently" ici
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: 
      [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(weatherData.currentWeather.temperature.toString()),
            Text(weatherData.currentWeatherUnits.temperature),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(weatherData.currentWeather.windspeed.toString()),
            Text(weatherData.currentWeatherUnits.windspeed),
          ],
        ),

      ]
    );
  }
}
