import 'package:flutter/material.dart';
import 'package:weather_final_proj/providers/city_provider.dart';
import 'package:weather_final_proj/widgets/weatherTabs/currently_weather_tab.dart';
import 'package:weather_final_proj/widgets/weatherTabs/today_weather_tab.dart';
import 'package:weather_final_proj/widgets/weatherTabs/weekly_weather_tab.dart';
class WeatherTabView extends StatelessWidget {
  final TabController tabController;
  final List<Tab> timeScaleTabs;
  final CityProvider cityProvider;

  const WeatherTabView({
    super.key,
    required this.tabController,
    required this.timeScaleTabs,
    required this.cityProvider,
  });

  @override
  Widget build(BuildContext context) {

    return TabBarView(
      controller: tabController,
      children: timeScaleTabs.map((Tab tab) {
        switch (tab.text) {
        case 'Currently':
          return CurrentlyWeatherTab(cityProvider: cityProvider);
        case 'Today':
          return TodayWeatherTab(cityProvider: cityProvider);
        case 'Weekly':
          return WeeklyWeatherTab(cityProvider: cityProvider);
        default:
          return const Text('No tab found');
        }
      }).toList(),
    );
  }
}