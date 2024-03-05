import 'package:flutter/material.dart';

class WeatherCodeDescription {
  final String description;
  final Icon icon;

  WeatherCodeDescription(this.description, this.icon);
}

class WeatherCode {
  static final Map<int, WeatherCodeDescription> _weatherCodeMap = {
    0: WeatherCodeDescription('Clear sky', const Icon(Icons.wb_sunny)),
    1: WeatherCodeDescription('Mainly clear', const Icon(Icons.wb_sunny)),
    2: WeatherCodeDescription('Partly cloudy', const Icon(Icons.cloud)),
    3: WeatherCodeDescription('Overcast', const Icon(Icons.cloud_queue)),
    45: WeatherCodeDescription('Fog', const Icon(Icons.foggy)),
    48: WeatherCodeDescription('Depositing rime fog', const Icon(Icons.foggy)),
    51: WeatherCodeDescription('Drizzle: Light intensity', const Icon(Icons.cloud_circle)),
    53: WeatherCodeDescription('Drizzle: Moderate intensity', const Icon(Icons.cloud_circle)),
    55: WeatherCodeDescription('Drizzle: Dense intensity', const Icon(Icons.cloud_circle)),
    56: WeatherCodeDescription('Freezing Drizzle: Light intensity', const Icon(Icons.cloud_circle)),
    57: WeatherCodeDescription('Freezing Drizzle: Dense intensity', const Icon(Icons.cloud_circle)),
    61: WeatherCodeDescription('Rain: Slight intensity', const Icon(Icons.cloud)),
    63: WeatherCodeDescription('Rain: Moderate intensity', const Icon(Icons.grain)),
    65: WeatherCodeDescription('Rain: Heavy intensity', const Icon(Icons.grain)),
    66: WeatherCodeDescription('Freezing Rain: Light intensity', const Icon(Icons.grain)),
    67: WeatherCodeDescription('Freezing Rain: Heavy intensity', const Icon(Icons.grain)),
    71: WeatherCodeDescription('Snow fall: Slight intensity', const Icon(Icons.snowing)),
    73: WeatherCodeDescription('Snow fall: Moderate intensity', const Icon(Icons.snowing)),
    75: WeatherCodeDescription('Snow fall: Heavy intensity', const Icon(Icons.snowing)),
    77: WeatherCodeDescription('Snow grains', const Icon(Icons.snowing)),
    80: WeatherCodeDescription('Rain showers: Slight intensity', const Icon(Icons.grain)),
    81: WeatherCodeDescription('Rain showers: Moderate intensity', const Icon(Icons.grain)),
    82: WeatherCodeDescription('Rain showers: Violent intensity', const Icon(Icons.grain)),
    85: WeatherCodeDescription('Snow showers: Slight intensity', const Icon(Icons.snowing)),
    86: WeatherCodeDescription('Snow showers: Heavy intensity', const Icon(Icons.snowing)),
    95: WeatherCodeDescription('Thunderstorm: Slight or moderate', const Icon(Icons.thunderstorm)),
    96: WeatherCodeDescription('Thunderstorm with slight hail', const Icon(Icons.thunderstorm)),
    99: WeatherCodeDescription('Thunderstorm with heavy hail', const Icon(Icons.thunderstorm)),
  };

  static WeatherCodeDescription getWeatherCodeDescription(int code) {
    return _weatherCodeMap.putIfAbsent(code, () => WeatherCodeDescription('Unknown', const Icon(Icons.question_mark)));
  }
}
