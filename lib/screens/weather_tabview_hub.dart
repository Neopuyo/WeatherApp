import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_final_proj/models/city_class.dart';
import 'package:weather_final_proj/models/weather_data.dart';
import 'package:weather_final_proj/providers/city_provider.dart';
import 'package:weather_final_proj/providers/connectivity_provider.dart';
import 'package:weather_final_proj/tools/geo_fetcher.dart';
import 'package:weather_final_proj/widgets/city_error_widget.dart';
import 'package:weather_final_proj/widgets/weatherTabs/weather_tab_view_widget.dart';

class WeatherTabViewHub extends StatelessWidget {
  final TabController tabController;
  final List<Tab> timeScaleTabs;

  const WeatherTabViewHub({super.key, 
    required this.tabController,
    required this.timeScaleTabs,
  });


  Widget _suggestionList({required CityProvider cityProvider}) {
    final GeoFetcher geoFetcher = GeoFetcher();

    return ListView.builder(
      itemCount: cityProvider.suggestionsCities.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(cityProvider.suggestionsCities[index].name),
          subtitle: _suggestionListTileSubtitle(
              cityProvider.suggestionsCities[index]),
          onTap: () async {
            cityProvider.submitCity(cityProvider.suggestionsCities[index]);
            try {
              WeatherData data = await geoFetcher.fetchForecastForCity(
                  cityProvider.selectedCity ?? City.tanukiCity());
              cityProvider.updateWeatherData(data);
            } catch (e) {
              cityProvider.setError(e.toString());
            }
          },
        );
      },
    );
  }

  Widget _suggestionListTileSubtitle(City city) {
    final String subtitle;

    if (city.region.isNotEmpty) {
      subtitle = "${city.region}, ${city.country}";
    } else {
      subtitle = city.country;
    }
    return Text(subtitle);
  }


  @override
  Widget build(BuildContext context) {

    return Consumer2<CityProvider, ConnectivityProvider>(
      builder: (context, cityProvider, connectivityProvider, child) {
        final bool shouldDisplaySuggestions = cityProvider.shouldDisplay;
        final CityError? error = cityProvider.error;
        final ConnectivityResult isConnected = connectivityProvider.connectivityResult;

        if (isConnected == ConnectivityResult.none) {
          return const CityErrorVirginWidget(message: "no internet connection available. Please check your settings. Or try later.");
        } else if (error != null) {
          return CityErrorWidget(error: error);
        } else if (shouldDisplaySuggestions) {
          return _suggestionList(cityProvider: cityProvider);
        } else {
          return WeatherTabView(
            tabController: tabController,
            timeScaleTabs: timeScaleTabs,
            cityProvider: cityProvider,
          );
        }
      }
    );
  }
}