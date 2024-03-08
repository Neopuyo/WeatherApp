import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_final_proj/design/weather_app_colors.dart';
import 'package:weather_final_proj/design/weather_app_theme.dart';
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
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
  super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        context.read<CityProvider>().updateKeyboardStatus(true);
      } else {
        context.read<CityProvider>().updateKeyboardStatus(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final GeoFetcher geoFetcher = GeoFetcher();


    return Consumer<CityProvider>(
      builder: (context, cityProvider, child) {
        return TextField(
          style: WeatherAppTheme.textfieldInput(),
          controller: widget.controller,
          focusNode: _focusNode,
          decoration: InputDecoration(
            hintText: 'Search location',
            hintStyle: WeatherAppTheme.textfieldHint(),
            border: InputBorder.none,
            icon: Icon(Icons.search, color: cityProvider.keyboardIsUp ? WAppColor.ACCENT : Colors.white),
          ),
          cursorColor: WAppColor.ACCENT,
          onChanged: (value) {
            if (value.length > 2) {
              _debounceTimer?.cancel();
              _debounceTimer = Timer(const Duration(milliseconds: 450), () {
                geoFetcher.fetchCities(value).then((cities) {
                  dev.log(
                      'GeoSearchField (onChanged): ${cities.length} cities found');
                  cityProvider.update(cities, value);
                }).catchError((e) {
                  dev.log('GeoSearchField (onChanged): ${e.toString()}');
                });
              });
            } else {
              _debounceTimer?.cancel();
              cityProvider.cancelingInput(value);
            }
          },
          onSubmitted: (String value) {
            if (value.isNotEmpty) {
              dev.log("[GeoSearchField] onSubmit CALLED !");
              cityProvider.submitCityByName(value);
              City? city = cityProvider.selectedCity;
              dev.log("[GeoSearchField] onSubmit city.name =  ${city?.name}");
              try {
                if (city == null) {
                  dev.log("[GeoSearchField] onSubmit city == null");
                  throw Exception("no weather data could be found for $value");
                }
                geoFetcher.fetchForecastForCity(city).then((weather) {
                      cityProvider.updateWeatherData(weather);
                }).catchError((e) {
                  cityProvider.setError(e.toString());
                });
              } catch(e) {
                cityProvider.setError(e.toString());
              }
            } else {
              dev.log('GeoSearchField (onSubmitted): empty value submited : skip it');
            }
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _focusNode.dispose();
    super.dispose();
  }
}