import 'package:flutter/material.dart';
import 'package:weather_final_proj/design/weather_app_colors.dart';
import 'package:weather_final_proj/design/weather_app_theme.dart';
import 'package:weather_final_proj/models/city_class.dart';
import 'package:weather_final_proj/models/weather_code.dart';
import 'package:weather_final_proj/models/weather_data.dart';
import 'package:weather_final_proj/providers/city_provider.dart';
import 'package:weather_final_proj/widgets/miniWidgets/card_mini_widget.dart';

class CurrentlyWeatherTab extends StatelessWidget {
  const CurrentlyWeatherTab({super.key, required this.cityProvider});

  final CityProvider cityProvider;

  @override
  Widget build(BuildContext context) {
    final WeatherData weatherData = cityProvider.weatherData;
    final int code = weatherData.currentWeather.weathercode;
    final String description =
        WeatherCode.getWeatherCodeDescription(code).description;

    Orientation orientation = MediaQuery.of(context).orientation;

    Widget orangeLine() {
      return Container(
        height: 1,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        width: 180,
        decoration: const BoxDecoration(
          color: WAppColor.SECONDARY,
          ),
      );
    }

    List<Widget> landscapeChildren = [
      //[1] City title
      CityNameCardWidget(
          city: cityProvider.selectedCity ?? City.tanukiCity()),

      // [2] Weather icon and description
      IconWithTextCard(
          icon: WeatherCode.getWeatherIcon(code: code, color: WAppColor.SECONDARY, size: 80),
          text: description),

      //[3] Temperature
      TemperatureCardWidget(
        child: RichText(
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
      ),

      if (orientation == Orientation.portrait)
        const Padding(padding: EdgeInsets.only(bottom: 1)),


      // [4] Wind speed
      WindSpeedCard(
          windSpeed:
              "${weatherData.currentWeather.windspeed.toString()} ${weatherData.currentWeatherUnits.windspeed}"),
    ];

    List<Widget> portraitChildren = [
      //[1] City title
      CityNameCardWidget(
          city: cityProvider.selectedCity ?? City.tanukiCity()),

      SizedBox(height: MediaQuery.of(context).size.height * 0.05),

      TemperatureCardWidget(child: 
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
              const SizedBox(height: 14.0, width: 10.0,),
              // [2] Weather icon and description
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                   WeatherCode.getWeatherIcon(code: code, color: WAppColor.SECONDARY, size: 90),
                   orangeLine(),
                   Text(description, 
                     maxLines: 4, 
                     style: Theme.of(context).textTheme.bodySmall?.
                      copyWith( 
                        color: WAppColor.PRIMARY
                      ),
                   ),
                   orangeLine(),
                ],
              ),

              // [3] Temperature
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

              // [4] Wind speed
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                   const Icon(Icons.air, color: WAppColor.PRIMARY, size: 18,),
                   const SizedBox(width: 5,),
                   Text("${weatherData.currentWeather.windspeed.toString()} ${weatherData.currentWeatherUnits.windspeed}",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith( color: WAppColor.PRIMARY),),
                ],
              ),

              const SizedBox(height: 24.0, width: 10.0,)
          ],
        )
      )

        
    ];

    return  Column(
        mainAxisAlignment: orientation == Orientation.landscape
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
        children: [Wrap(
            direction: orientation == Orientation.landscape
                ? Axis.horizontal
                : Axis.vertical,
            crossAxisAlignment: orientation == Orientation.landscape
                ? WrapCrossAlignment.start
                : WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            spacing: MediaQuery.of(context).size.height * 0.05,
            runSpacing: 20.0,
            children: orientation == Orientation.landscape
                ? landscapeChildren
                : portraitChildren
            ),
        ],
    );
  }
}
