import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_final_proj/design/weather_app_theme.dart';
import 'package:weather_final_proj/providers/city_provider.dart';
import 'package:weather_final_proj/providers/connectivity_provider.dart';
import 'screens/weather_app_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CityProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ConnectivityProvider(),
        ),
      ],
      child: MaterialApp(
        home: const WeatherAppScreen(key: Key("weather_app_screen")),
        theme: WeatherAppTheme.getWeatherAppTheme(),
      ),
    );
  }

}