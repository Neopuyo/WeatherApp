import 'package:flutter/material.dart';
import 'package:weather_final_proj/models/city_class.dart';
import 'package:weather_final_proj/providers/city_provider.dart';
import 'package:weather_final_proj/widgets/miniWidgets/card_mini_widget.dart';
import 'package:weather_final_proj/widgets/miniWidgets/charts.dart';
import 'package:weather_final_proj/widgets/miniWidgets/lists.dart';

class WeeklyWeatherTab extends StatelessWidget {
  final CityProvider cityProvider;

  const WeeklyWeatherTab({super.key, required this.cityProvider});

  @override
  Widget build(BuildContext context) {

    final List<Widget> children = 
    [
      CityNameCardWidget(city: cityProvider.selectedCity ?? City.tanukiCity()),
      WeeklyTemperatureChart(cityProvider: cityProvider),
      WeeklyList(cityProvider: cityProvider),
    ];

  return Center(
        child: MediaQuery.of(context).orientation == Orientation.portrait 
        ? Column(
          children: children
        )
        : Row(
          children: children,
        ),
    );
  }
}







/*
return SizedBox(
      height: MediaQuery.of(context).size.height * 0.50,
      child: ListView.separated(
        separatorBuilder: (context, index) => const Divider(height:1, color: Colors.grey, thickness: 0.5, indent: 10, endIndent: 10),
        itemCount: cityProvider.weatherData.daily.time.length,
        itemBuilder: (context, index) {
            final String time = cityProvider.weatherData.daily.time[index];
            final DateTime dateTime = DateTime.parse(time);
            final String formatedTime = DateFormat.MEd().format(dateTime);
            final int weatherCode = cityProvider.weatherData.daily.weatherCode[index];
            final double minTemp = cityProvider.weatherData.daily.temperature2mMin[index];
            final String tempUnit = cityProvider.weatherData.dailyUnits.temperature2mMin;
            final double maxTemp = cityProvider.weatherData.daily.temperature2mMax[index];
      
            return ListTile(
              visualDensity: VisualDensity.compact,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatedTime),
                  Icon(WeatherCode.getWeatherCodeDescription(weatherCode).iconData, color: Colors.blueGrey, size: 12,),
                  SizedBox(
                    width: 50,
                    child: Text(
                      WeatherCode.getWeatherCodeDescription(weatherCode).description,
                      style: const TextStyle(color: Colors.blueGrey, fontSize: 8),
                      overflow: TextOverflow.ellipsis),
                    ),
                  Text("${minTemp.toString()} $tempUnit ~ ${maxTemp.toString()} $tempUnit"),
                ],
              ),
            );
        },
      ),
    );
*/