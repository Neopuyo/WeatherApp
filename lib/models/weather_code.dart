import 'package:flutter/material.dart';

class WeatherCodeDescription {
  final String description;
  final IconData iconData;

  WeatherCodeDescription(this.description, this.iconData);
}

class WeatherCode {
  static final Map<int, WeatherCodeDescription> _weatherCodeMap = {
    0: WeatherCodeDescription('Clear sky', Icons.wb_sunny),
    1: WeatherCodeDescription('Mainly clear', Icons.wb_sunny),
    2: WeatherCodeDescription('Partly cloudy', Icons.cloud),
    3: WeatherCodeDescription('Overcast', Icons.cloud_queue),
    45: WeatherCodeDescription('Fog', Icons.foggy),
    48: WeatherCodeDescription('Depositing rime fog', Icons.foggy),
    51: WeatherCodeDescription('Drizzle: Light intensity', Icons.cloud_circle),
    53: WeatherCodeDescription('Drizzle: Moderate intensity', Icons.cloud_circle),
    55: WeatherCodeDescription('Drizzle: Dense intensity', Icons.cloud_circle),
    56: WeatherCodeDescription('Freezing Drizzle: Light intensity', Icons.cloud_circle),
    57: WeatherCodeDescription('Freezing Drizzle: Dense intensity', Icons.cloud_circle),
    61: WeatherCodeDescription('Rain: Slight intensity', Icons.cloud),
    63: WeatherCodeDescription('Rain: Moderate intensity', Icons.grain),
    65: WeatherCodeDescription('Rain: Heavy intensity', Icons.grain),
    66: WeatherCodeDescription('Freezing Rain: Light intensity', Icons.grain),
    67: WeatherCodeDescription('Freezing Rain: Heavy intensity', Icons.grain),
    71: WeatherCodeDescription('Snow fall: Slight intensity', Icons.snowing),
    73: WeatherCodeDescription('Snow fall: Moderate intensity', Icons.snowing),
    75: WeatherCodeDescription('Snow fall: Heavy intensity', Icons.snowing),
    77: WeatherCodeDescription('Snow grains', Icons.snowing),
    80: WeatherCodeDescription('Rain showers: Slight intensity', Icons.grain),
    81: WeatherCodeDescription('Rain showers: Moderate intensity', Icons.grain),
    82: WeatherCodeDescription('Rain showers: Violent intensity', Icons.grain),
    85: WeatherCodeDescription('Snow showers: Slight intensity', Icons.snowing),
    86: WeatherCodeDescription('Snow showers: Heavy intensity', Icons.snowing),
    95: WeatherCodeDescription('Thunderstorm: Slight or moderate', Icons.thunderstorm),
    96: WeatherCodeDescription('Thunderstorm with slight hail', Icons.thunderstorm),
    99: WeatherCodeDescription('Thunderstorm with heavy hail', Icons.thunderstorm),
  };

  static WeatherCodeDescription getWeatherCodeDescription(int code) {
    return _weatherCodeMap.putIfAbsent(code, () => WeatherCodeDescription('Unknown', Icons.question_mark));
  }

  static Icon getWeatherIcon({int code = 0, Color color = Colors.black, double size = 24}) {
    final description = getWeatherCodeDescription(code);
    return Icon(description.iconData, color: color, size: size);
  }
}
