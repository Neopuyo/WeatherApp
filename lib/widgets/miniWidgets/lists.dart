import 'package:flutter/material.dart';
import 'package:weather_final_proj/models/weather_data.dart';
import 'package:weather_final_proj/providers/city_provider.dart';
import 'package:weather_final_proj/widgets/miniWidgets/card_mini_widget.dart';

class DailyList extends StatelessWidget {

  final CityProvider cityProvider;

  const DailyList({super.key, required this.cityProvider});
  
  @override
  Widget build(BuildContext context) {
    
    final WeatherData weaterData = cityProvider.weatherData;
    final List<String> hours = weaterData.getDailyHoursAsString();
    final List<String> temperatures = weaterData.getDailyTemperaturesWithUnit();
    final List<IconData> iconsData = weaterData.getDailyIconsData();
    final List<String> windspeeds = weaterData.getDailyWindSpeeds();
    
    return Expanded(
      child: ListView.builder(
        itemCount: hours.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Text("${hours[index]}h00"),
              Icon(iconsData[index]),
              Text(temperatures[index]),
              // Text(windspeeds[index]),
              WindSpeedCard(windSpeed: windspeeds[index])
            ],
          );
        },
      ),
    );

  }


}