import 'package:flutter/material.dart';
import 'package:weather_final_proj/design/weather_app_colors.dart';
import 'package:weather_final_proj/design/weather_app_theme.dart';
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

    Orientation orientation = MediaQuery.of(context).orientation;
    
    return Expanded(
      
      child: ListView.builder(
          itemCount: hours.length,
          scrollDirection: orientation == Orientation.portrait ? Axis.horizontal : Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                if (MediaQuery.of(context).orientation == Orientation.portrait)
                Text("${hours[index]}h00",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,                        ),
                ),
        
                OrangeCardWidget(
                  child: Column(
                    children: [
                      if (MediaQuery.of(context).orientation == Orientation.portrait)
                        const SizedBox(height: 10.0, width: 10.0,),
                      if (MediaQuery.of(context).orientation == Orientation.landscape)
                      Text("${hours[index]}h00",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,                        ),
                      ),
                      Icon(iconsData[index], size: 60.0, ),
                      Text(temperatures[index], style: WeatherAppTheme.dailyTemperature()),
                      WindSpeedCard(windSpeed: windspeeds[index], size: CardSize.compact,),
                      const SizedBox(height: 10.0, width: 10.0),
                    ]
                  ),
                ),
                
              ],
            );
          },
        ),
    );

  }


}



class WeeklyList extends StatelessWidget {

  final CityProvider cityProvider;

  const WeeklyList({super.key, required this.cityProvider});

  
  @override
  Widget build(BuildContext context) {
    
    Widget dayWidget({required String day}) {
      return  Container(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: WAppColor.TEXT_COLOR, width: 0.5
    )
        ),
        child: Text(day,
          style: Theme.of(context).textTheme.bodyLarge?.
            copyWith(fontWeight: FontWeight.bold)
        ),
      );
    }

    List<Widget> temperatureWidget({required String tempMin, required String tempMax}) {
      return [
        Text(tempMin, style: WeatherAppTheme.WeeklyTemperature(isMin: true)),
        const SizedBox(width: 10.0, height: 0,),
        Text(tempMax, style: WeatherAppTheme.WeeklyTemperature(isMin: false))
      ];
    }

    final WeatherData weatherData = cityProvider.weatherData;
    final List<String> days = weatherData.getDays();
    final List<String> temperaturesMin = weatherData.getWeeklyTemperaturesWithUnit(min: true);
    final List<String> temperaturesMax = weatherData.getWeeklyTemperaturesWithUnit(max: true);
    final List<IconData> iconsData = weatherData.getWeeklyIconsData();

    Orientation orientation = MediaQuery.of(context).orientation;
    
    return Expanded(
      
      child: ListView.builder(
          itemCount: days.length,
          scrollDirection: orientation == Orientation.portrait ? Axis.horizontal : Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            
            List<Widget> tempChildren = temperatureWidget(tempMin: temperaturesMin[index], tempMax: temperaturesMax[index]);
            
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                if (MediaQuery.of(context).orientation == Orientation.portrait)
                  dayWidget(day: days[index]),
                
        
                OrangeCardWidget(
                  child: Column(
                    children: [
                      const SizedBox(height: 10.0, width: 10.0,),
                      if (MediaQuery.of(context).orientation == Orientation.landscape)
                        dayWidget(day: days[index]),
                      Icon(iconsData[index], size: 60.0, ),
                      
                      Center(
                        child: MediaQuery.of(context).orientation == Orientation.portrait 
                        ? Column(
                          children: tempChildren,
                        )
                        : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: tempChildren,
                        )
                      )
                    ]
                  ),
                ),
              ],
            );
          },
        ),
    );

  }


}