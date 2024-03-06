import 'package:flutter/material.dart';
import 'package:weather_final_proj/models/city_class.dart';
import 'package:weather_final_proj/providers/city_provider.dart';
import 'package:weather_final_proj/tools/geo_fetcher.dart';
import 'package:weather_final_proj/tools/geo_handler.dart';
import 'package:weather_final_proj/widgets/geo_search_field.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as dev;

typedef StringCallback = void Function(String value);
typedef VoidCallback = void Function();

class TopBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final GeolocatorHandler geoHandler;
  final VoidCallback onPositionButtonForce;

  const TopBarWidget({super.key, required this.geoHandler, required this.onPositionButtonForce});

  @override
  Widget build(BuildContext context) {

    // To keep the search input text when onChanged is called
    final TextEditingController controller = TextEditingController();
    controller.text = context.watch<CityProvider>().searchInput;
    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: controller.text.length),
    );
    if (context.watch<CityProvider>().shouldResignFocus) {
      FocusScope.of(context).unfocus();
      context.read<CityProvider>().shouldResignFocus = false;
    }

    return AppBar(
      actions: [  
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: GeoSearchField(
              controller: controller,
            ),
          ),
        ),
        
        IconButton(
          icon: const Icon(Icons.near_me, color: Colors.white, size: 30.0),
          padding: const EdgeInsets.only(right: 30.0),
          onPressed: () async {
            onPositionButtonForce();
            final GeoFetcher geoFetcher = GeoFetcher();

            controller.clear();
            context.read<CityProvider>().clear();
            FocusScope.of(context).unfocus();
            try {
              if (geoHandler.currentPosition != null) {
                final latitude = geoHandler.currentPosition?.latitude;
                final longitude = geoHandler.currentPosition?.longitude;
                final City city;

                if (latitude != null && longitude != null) {
                  city = await geoFetcher.fetchCityByCoordinates(latitude, longitude);
                  if (!context.mounted) {
                    throw Exception("Error while updating your position, please try again later.");
                  }
                  context.read<CityProvider>().targetCity(city);
                  geoFetcher.fetchForecastForCity(city).then((data) {
                    dev.log("[Near_Me button] update weatherdata from position");
                    context.read<CityProvider>().updateWeatherData(data);
                  }).catchError((e) {
                    dev.log("error using MyPosition button $e");
                    context.read<CityProvider>().setError(e.toString());
                  });
                }
              }
            } catch (e) {
              dev.log("error using MyPosition button $e");
              context.read<CityProvider>().setError(e.toString());
            }
          },
        ),
      ],
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}