import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:weather_final_proj/design/weather_app_colors.dart';
import 'package:weather_final_proj/models/city_class.dart';
import 'package:weather_final_proj/models/weather_data.dart';
import 'package:weather_final_proj/providers/city_provider.dart';
import 'package:weather_final_proj/screens/weather_tabview_hub.dart';
import 'package:weather_final_proj/tools/geo_fetcher.dart';
import 'package:weather_final_proj/tools/geo_handler.dart';
import 'package:weather_final_proj/widgets/top_bar_widget.dart';
import 'package:weather_final_proj/widgets/bottom_bar_widget.dart';
import 'dart:developer' as dev;



class WeatherAppScreen extends StatefulWidget {
  const WeatherAppScreen({super.key});

  @override
  State<WeatherAppScreen> createState() => _WeatherAppScreenState();
}

// extension SingleTickerProviderStateMixin to use a TabController
class _WeatherAppScreenState extends State<WeatherAppScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late GeolocatorHandler _geoHandler;

  String locationValue = "";
  bool isLocationEnabled = false;
  bool isFirstTime = true;


  static const List<Tab> timeScaleTabs = <Tab>[
    Tab(text: 'Currently', icon:Icon(Icons.crop_free_outlined)),
    Tab(text: 'Today', icon:Icon(Icons.crop_5_4_outlined)),
    Tab(text: 'Weekly', icon:Icon(Icons.view_week_outlined)),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: timeScaleTabs.length);
    _geoHandler = GeolocatorHandler(() async {
       _checkPermissionChange();
       _setPositionAsTargetCity();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _checkPermissionChange() {
    bool oldStatus = isLocationEnabled;
    bool newStatus = _geoHandler.isLocationEnabled;
    if (oldStatus != newStatus) {
      setState(() {
        dev.log("PermissionStatus of location : $newStatus");
        isLocationEnabled = newStatus;
      });
    } else {
      dev.log("PermissionStatus of location is still $newStatus");
    }
  }

  void _onPositionButtonForce() {
    setState(() {
      isFirstTime = true;
    });
  }

  void _setPositionAsTargetCity() async {
    GeoFetcher geoFetcher = GeoFetcher();

    try {
      if (_geoHandler.currentPosition != null) {
        final latitude = _geoHandler.currentPosition?.latitude;
        final longitude = _geoHandler.currentPosition?.longitude;
        final City city;

        if (latitude != null && longitude != null) {
          city = await geoFetcher.fetchCityByCoordinates(latitude, longitude);
          if (!mounted) {
            throw Exception(
                "Error while updating your position, please try again later.");
          } else {
            context.read<CityProvider>().targetCity(city);
            _fetchPositionForecast(geoFetcher, city);
          }
        }
      }
    } catch (e) {
      dev.log("error while _setPositionAsTargetCity $e");
      if (mounted) {
        context.read<CityProvider>().setError(e.toString());
      }
    }
  }

  void _fetchPositionForecast(GeoFetcher geofetcher, City city) async {
    WeatherData weatherData;
    try {
      weatherData = await geofetcher.fetchForecastForCity(city);
      if (mounted) {
        context.read<CityProvider>().updateWeatherData(weatherData);
      }
    } catch (e) {
      dev.log("error while _fetchPositionForecast $e");
      if (mounted) {
        context.read<CityProvider>().setError(e.toString());
      }
    }
  }

  // private widget
  Widget _noGpsPermission() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
"""
GPS Permission denied ! 
enable location settings 
to enable WeatherApp access
your position.
You can still use the app
""",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  isFirstTime = false;
                });
              },
              child: const Text("Continue using app"))
        ],
      ),
    );
  }

  Widget _prepareWeatherTabViewHub(BuildContext context) {
    if (!isLocationEnabled && isFirstTime) {
      return _noGpsPermission();
    } else {
      return WeatherTabViewHub(
        tabController: _tabController,
        timeScaleTabs: timeScaleTabs,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
      return Stack(
    children: [
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            // [!] Sonic will proove that background is all screen size
            // image: const AssetImage("assets/images/sonic.webp"),
            image: const AssetImage("assets/images/weather_background.jpg"),
            colorFilter: ColorFilter.mode(
                WAppColor.BG_COLOR.withOpacity(0.65), BlendMode.multiply),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent, // set background color to transparent
        appBar: TopBarWidget(geoHandler: _geoHandler, onPositionButtonForce: _onPositionButtonForce),
        body: _prepareWeatherTabViewHub(context),
        bottomNavigationBar: BottomBarWidget(tabController: _tabController, timeScaleTabs: timeScaleTabs),
      ),
    ],
  );
}
}