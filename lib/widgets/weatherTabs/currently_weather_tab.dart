import 'package:flutter/material.dart';
import 'package:weather_final_proj/design/weather_app_colors.dart';
import 'package:weather_final_proj/design/weather_app_theme.dart';
import 'package:weather_final_proj/models/weather_code.dart';
import 'package:weather_final_proj/models/weather_data.dart';
import 'package:weather_final_proj/providers/city_provider.dart';

class CurrentlyWeatherTab extends StatelessWidget {
  const CurrentlyWeatherTab({super.key, required this.cityProvider});

  final CityProvider cityProvider;

  @override
  Widget build(BuildContext context) {
    final WeatherData weatherData = cityProvider.weatherData;
    final int code = weatherData.currentWeather.weathercode;
    // Construisez l'interface utilisateur de l'onglet "Currently" ici
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: 
      [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: 
        [
          const Spacer(),
          RichText(
            text: TextSpan(children: [
              WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Text(
                    weatherData.currentWeather.temperature.toString(),
                    style: WeatherAppTheme.currentlyTemperature(),
                  )),
              WidgetSpan(
                  alignment: PlaceholderAlignment.top,
                  child: Text(
                    weatherData.currentWeatherUnits.temperature,
                    style: WeatherAppTheme.currentlyTemperatureUnit(),
                  )),
            ]),
          ),
          const Spacer(),
          
              WeatherCode.getWeatherIcon(code: code, color: WAppColor.PRIMARY, size: 88),
              
            
          
          const Spacer(),
        ],
      ),
        
        
        // WeatherCode.getWeatherIcon(code: weatherData.currentWeather.weathercode, color: Colors.blueGrey, size: 48),
       Text(
                    WeatherCode.getWeatherCodeDescription(67).description,
                    overflow: TextOverflow.ellipsis),
       
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
