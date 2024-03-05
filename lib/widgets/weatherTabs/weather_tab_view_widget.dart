import 'package:flutter/material.dart';
import 'package:weather_final_proj/models/city_class.dart';
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

  Widget _weatherTabHub({required Tab tab, required CityProvider cityProvider}) {
    switch (tab.text) {
      case 'Currently':
        return CurrentlyWeatherTab(cityProvider: cityProvider,);
      case 'Today':
        return TodayWeatherTab(cityProvider: cityProvider);
      case 'Weekly':
        return WeeklyWeatherTab(cityProvider: cityProvider);
      default:
        return const Text('No tab found');
    }
  }

  Widget _cityLocationWidget(City city) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          city.name,
          style: const TextStyle(
            fontSize: 24, 
            color: Color.fromARGB(255, 13, 99, 126),
            fontWeight: FontWeight.bold
          ),
        ),
        Text(
          city.region,
          style: const TextStyle(
            fontSize: 18, 
            color: Colors.grey,
          ),
        ),
        Text(
          city.country,
          style: const TextStyle(
            fontSize: 18, 
            color: Colors.grey,
          ),
        )
      ],
    );
  }


  @override
  Widget build(BuildContext context) {

    return TabBarView(
      controller: tabController,
      children: timeScaleTabs.map((Tab tab) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _cityLocationWidget(cityProvider.selectedCity ?? City.tanukiCity()),
            _weatherTabHub(tab: tab, cityProvider: cityProvider),
          ],
        );
      }).toList(),
    );
  }
}