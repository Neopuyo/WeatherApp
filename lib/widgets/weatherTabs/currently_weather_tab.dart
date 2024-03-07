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

    return  Center(
        child: Wrap(
            direction: orientation == Orientation.landscape
                ? Axis.horizontal
                : Axis.vertical,
            crossAxisAlignment: orientation == Orientation.landscape
                ? WrapCrossAlignment.start
                : WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            spacing: MediaQuery.of(context).size.height * 0.05,
            runSpacing: 20.0,
            children: [
              //[1] City title
              CityNameCardWidget(
                  city: cityProvider.selectedCity ?? City.tanukiCity()),

              if (orientation == Orientation.portrait)
                Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.025)),

              //[2] Temperature
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

              // [3] Weather icon and description
              IconWithTextCard(
                  icon: WeatherCode.getWeatherIcon(code: code, color: WAppColor.PRIMARY, size: 80),
                  text: description),

              // [4] Wind speed
              WindSpeedCard(
                  windSpeed:
                      "${weatherData.currentWeather.windspeed.toString()} ${weatherData.currentWeatherUnits.windspeed}"),

              if (orientation == Orientation.portrait)
                const Padding(padding: EdgeInsets.only(bottom: 1)),
            ]),
    );
  }
}
