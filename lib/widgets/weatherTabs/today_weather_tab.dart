import 'package:flutter/material.dart';
import 'package:weather_final_proj/design/weather_app_colors.dart';
import 'package:weather_final_proj/models/city_class.dart';

import 'package:weather_final_proj/providers/city_provider.dart';
import 'package:weather_final_proj/widgets/miniWidgets/card_mini_widget.dart';
import 'package:weather_final_proj/widgets/miniWidgets/charts.dart';
import 'package:weather_final_proj/widgets/miniWidgets/lists.dart';

class TodayWeatherTab extends StatelessWidget {

  final CityProvider cityProvider;

  const TodayWeatherTab({super.key, required this.cityProvider});


  @override
  Widget build(BuildContext context) {
  return Container( // [!] ONLY TO SEE THE WIDGET
      decoration: BoxDecoration(
        border: Border.all(
          color: WAppColor.SECONDARY,
          width: 2.0,
        ),
      ),
      child: Center(
        child: Column(
          children: 
          [
            CityNameCardWidget(city: cityProvider.selectedCity ?? City.tanukiCity()),
            DailyTemperatureChart(cityProvider: cityProvider),
            DailyList(cityProvider: cityProvider),

            
      
          ],
        ),
      ),
    );
  }




}



/*

return SizedBox(
      height: MediaQuery.of(context).size.height * 0.10,
      child: ListView.separated(
        separatorBuilder: (context, index) => const Divider(
            height: 1,
            color: Colors.grey,
            thickness: 0.5,
            indent: 10,
            endIndent: 10),
        itemCount: cityProvider.weatherData.hourly.time.length <= 24
            ? cityProvider.weatherData.hourly.time.length
            : 24,
        itemBuilder: (context, index) {
          final String time = cityProvider.weatherData.hourly.time[index];
          final DateTime dateTime = DateTime.parse(time);
          final String formatedTime = DateFormat.Hm().format(dateTime);
          final int weatherCode =
              cityProvider.weatherData.hourly.weatherCode[index];

          return ListTile(
            visualDensity: VisualDensity.compact,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(formatedTime),
                Icon(
                  WeatherCode.getWeatherCodeDescription(weatherCode).iconData,
                  color: Colors.blueGrey,
                  size: 12,
                ),
                SizedBox(
                  width: 50,
                  child: Text(
                      WeatherCode.getWeatherCodeDescription(weatherCode).description,
                      style:
                          const TextStyle(color: Colors.blueGrey, fontSize: 8),
                      overflow: TextOverflow.ellipsis),
                ),
                Text(
                  "${cityProvider.weatherData.hourly.temperature2m[index].toString()} ${cityProvider.weatherData.hourlyUnits.temperature2m}",
                ),
                Text(
                    "${cityProvider.weatherData.hourly.windSpeed10m[index].toString()} ${cityProvider.weatherData.hourlyUnits.windSpeed10m}"),
              ],
            ),
          );
        },
      ),
    );

    */
