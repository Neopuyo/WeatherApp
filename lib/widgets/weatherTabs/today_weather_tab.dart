import 'package:flutter/material.dart';
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

    final List<Widget> children = 
    [
      CityNameCardWidget(city: cityProvider.selectedCity ?? City.tanukiCity()),
      DailyTemperatureChart(cityProvider: cityProvider),
      DailyList(cityProvider: cityProvider),
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
