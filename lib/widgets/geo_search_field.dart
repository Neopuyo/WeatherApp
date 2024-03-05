import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_final_proj/models/city_class.dart';
import 'package:weather_final_proj/providers/city_provider.dart';
import 'package:weather_final_proj/tools/geo_fetcher.dart';
import 'dart:developer' as dev;


class GeoSearchField extends StatefulWidget {
  final TextEditingController controller;

  const GeoSearchField({
    super.key, 
    required this.controller, 
  });

  @override
  State<GeoSearchField> createState() => _GeoSearchFieldState();
}

class _GeoSearchFieldState extends State<GeoSearchField> {

  Timer? _debounceTimer;

  @override
  Widget build(BuildContext context) {
    final GeoFetcher geoFetcher = GeoFetcher();
    
    return TextField(
      controller: widget.controller,
      decoration: const InputDecoration(
        hintText: 'Search location',
        hintStyle:
            TextStyle(color: Color.fromARGB(255, 13, 99, 126), fontSize: 16),
        border: InputBorder.none,
        icon: Icon(Icons.search, color: Colors.white),
      ),
       onChanged: (value) {
        if (value.length > 2) {
          _debounceTimer?.cancel();
          _debounceTimer = Timer(const Duration(milliseconds: 450), () {
              geoFetcher.fetchCities(value).then((cities) {
                dev.log(
                    'GeoSearchField (onChanged): ${cities.length} cities found');
                context.read<CityProvider>().update(cities, value);
              })
              .catchError((e) {
                dev.log('GeoSearchField (onChanged): ${e.toString()}');
              });
          });
        } else {
          _debounceTimer?.cancel();
          context.read<CityProvider>().cancelingInput(value);
        }
      },
      onSubmitted: (String value) {
        if (value.isNotEmpty) {
          dev.log("[GeoSearchField] onSubmit CALLED !");
          context.read<CityProvider>().submitCityByName(value);
          City? city = context.read<CityProvider>().selectedCity;
          dev.log("[GeoSearchField] onSubmit city.name =  ${city?.name}");
          try {
            if (city == null) {
              dev.log("[GeoSearchField] onSubmit city == null");
              throw Exception("no weather data could be found for $value");
            }
            geoFetcher.fetchForecastForCity(city).then((weather) {
                  context.read<CityProvider>().updateWeatherData(weather);
            }).catchError((e) {
              context.read<CityProvider>().setError(e.toString());
            });
          } catch(e) {
            context.read<CityProvider>().setError(e.toString());
          }
        } else {
          dev.log('GeoSearchField (onSubmitted): empty value submited : skip it');
        }
      },
    );
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}