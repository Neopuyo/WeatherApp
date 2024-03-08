// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_final_proj/models/weather_code.dart';

part 'weather_data.g.dart';

@JsonSerializable()
class WeatherData {
  final double latitude;
  final double longitude;
  @JsonKey(name: 'generationtime_ms')
  final double generationtimeMs;
  @JsonKey(name: 'utc_offset_seconds')
  final int utcOffsetSeconds;
  final String timezone;
  @JsonKey(name: 'timezone_abbreviation')
  final String timezoneAbbreviation;
  final double elevation;
  @JsonKey(name: 'current_weather_units')
  final CurrentWeatherUnits currentWeatherUnits;
  @JsonKey(name: 'current_weather')
  final CurrentWeather currentWeather;
  @JsonKey(name: 'hourly_units')
  final HourlyUnits hourlyUnits;
  final Hourly hourly;
  @JsonKey(name: 'daily_units')
  final DailyUnits dailyUnits;
  final Daily daily;

  WeatherData({
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.generationtimeMs = 0.0,
    this.utcOffsetSeconds = 0,
    this.timezone = '',
    this.timezoneAbbreviation = '',
    this.elevation = 9999.0,
    this.currentWeatherUnits = const CurrentWeatherUnits.empty(),
    this.currentWeather = const CurrentWeather.empty(),
    this.hourlyUnits = const HourlyUnits.empty(),
    this.hourly = const Hourly.empty(),
    this.dailyUnits = const DailyUnits.empty(),
    this.daily = const Daily.empty(),
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) =>
      _$WeatherDataFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherDataToJson(this);
  
  const WeatherData.tanukiWeather()
  : latitude = 32.5,
    longitude = 131.6875,
    generationtimeMs = 0.08308887481689453,
    utcOffsetSeconds = 0,
    timezone = "Europe/London",
    timezoneAbbreviation = "GMT",
    elevation = 31.0,
    currentWeatherUnits = const CurrentWeatherUnits.tanuki(),
    currentWeather = const CurrentWeather.tanuki(),
    hourlyUnits = const HourlyUnits.tanuki(),
    hourly = const Hourly.tanuki(),
    dailyUnits = const DailyUnits.tanuki(),
    daily = const Daily.tanuki();


  List<double> getDailyHours() {
    final int maxList = hourly.time.length > 24 ? 24 : hourly.time.length;
    final List<String> hoursRawString = hourly.time.sublist(0, maxList);
    final List<String> hoursString = hoursRawString.map((value) {
      final DateTime dateTime = DateTime.parse(value);
      return dateTime.hour.toString();
    }).toList();
    return hoursString.map((value) => double.parse(value)).toList();
  }

  List<String> getDailyHoursAsString() {
    final int maxList = hourly.time.length > 24 ? 24 : hourly.time.length;
    final List<String> hoursRawString = hourly.time.sublist(0, maxList);
    final List<String> hoursString = hoursRawString.map((value) {
      final DateTime dateTime = DateTime.parse(value);
      return dateTime.hour.toString();
    }).toList();
    return hoursString;
  }

  List<String> getDailyTemperaturesWithUnit() {
    final int maxList = hourly.temperature2m.length > 24 ? 24 : hourly.temperature2m.length;
    final List<String> temperatures = hourly.temperature2m.sublist(0, maxList).map((value) => value.toString() + hourlyUnits.temperature2m).toList();
    return temperatures;
  }

  

  List<String> getWeeklyTemperaturesWithUnit({bool min=false, bool max=false}) {
    switch ((min, max)) {
      case (true, false):
        return daily.temperature2mMin.map((value) => value.toString() + dailyUnits.temperature2mMin).toList();
      case (false, true):
        return daily.temperature2mMax.map((value) => value.toString() + dailyUnits.temperature2mMax).toList();
      default:
        return daily.temperature2mMin.map((value) => value.toString() + dailyUnits.temperature2mMin).toList();
    }
  }

  List<IconData> getDailyIconsData() {
    final int maxList = hourly.weatherCode.length > 24 ? 24 : hourly.weatherCode.length;
    final List<int> weatherCodes = hourly.weatherCode.sublist(0, maxList);
    return weatherCodes.map((code) {
       return WeatherCode.getWeatherCodeDescription(code).iconData;
    }).toList();
  }

  List<IconData> getWeeklyIconsData() {
    final List<int> weatherCodes = daily.weatherCode;
    return weatherCodes.map((code) {
       return WeatherCode.getWeatherCodeDescription(code).iconData;
    }).toList();
  }

  List<String> getDailyWindSpeeds() {
    final int maxList = hourly.windSpeed10m.length > 24 ? 24 : hourly.windSpeed10m.length;
    final List<String> windSpeeds = hourly.windSpeed10m.sublist(0, maxList).map((value) => value.toString() + hourlyUnits.windSpeed10m).toList();
    return windSpeeds;
  }

  List<String> getDays() {
    final int maxList = daily.time.length > 7 ? 7 : daily.time.length;
    final List<String> daysRawString = daily.time.sublist(0, maxList);
    final List<String> daysString = daysRawString.map((value) {
      final DateTime dateTime = DateTime.parse(value);
      final String formattedDate = DateFormat('dd/MM').format(dateTime);
      return formattedDate;
    }).toList();
    return daysString;
  }

}

@JsonSerializable()
class CurrentWeatherUnits {
  final String time;
  final String interval;
  final String temperature;
  final String windspeed;
  final String winddirection;
  @JsonKey(name: 'is_day')
  final String isDay;
  final String weathercode;

  CurrentWeatherUnits({
    this.time = '',
    this.interval = '',
    this.temperature = '',
    this.windspeed = '',
    this.winddirection = '',
    this.isDay = '',
    this.weathercode = '',
  });

  const CurrentWeatherUnits.empty()
  : time = '',
    interval = '',
    temperature = '',
    windspeed = '',
    winddirection = '',
    isDay = '',
    weathercode = '';

  const CurrentWeatherUnits.tanuki()
  : time = "iso8601",
    interval = "seconds",
    temperature = "°C",
    windspeed = "km/h",
    winddirection = "°",
    isDay = "true",
    weathercode  = "wmo code";

  factory CurrentWeatherUnits.fromJson(Map<String, dynamic> json) =>
      _$CurrentWeatherUnitsFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentWeatherUnitsToJson(this);

}

@JsonSerializable()
class CurrentWeather {
  final String time;
  final int interval;
  final double temperature;
  final double windspeed;
  final int winddirection;
  @JsonKey(name: 'is_day')
  final int isDay;
  final int weathercode;

  CurrentWeather({
    this.time = '',
    this.interval = 0,
    this.temperature = 0.0,
    this.windspeed = 0.0,
    this.winddirection = 0,
    this.isDay = 0,
    this.weathercode = 0,
  });

  const CurrentWeather.empty()
  : time = '',
    interval = 0,
    temperature = 0.0,
    windspeed = 0.0,
    winddirection = 0,
    isDay = 0,
    weathercode = 0;

  const CurrentWeather.tanuki()
  : time = "2024-03-03T11:00",
    interval = 900,
    temperature = 8.9,
    windspeed = 12.6,
    winddirection = 284,
    isDay = 0,
    weathercode = 0;

  factory CurrentWeather.fromJson(Map<String, dynamic> json) =>
      _$CurrentWeatherFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentWeatherToJson(this);
}

@JsonSerializable()
class HourlyUnits {
  final String time;
  @JsonKey(name: 'temperature_2m')
  final String temperature2m;
  final String weatherCode;
  @JsonKey(name: 'wind_speed_10m')
  final String windSpeed10m;

  HourlyUnits({
    this.time = '',
    this.temperature2m = '',
    this.weatherCode = '',
    this.windSpeed10m = '',
  });

  const HourlyUnits.empty()
  : time = '',
    temperature2m = '',
    weatherCode = '',
    windSpeed10m = '';

  const HourlyUnits.tanuki()
  : time = "iso8601",
    temperature2m = "°C",
    weatherCode = "wmo code",
    windSpeed10m = "km/h";

  factory HourlyUnits.fromJson(Map<String, dynamic> json) =>
      _$HourlyUnitsFromJson(json);

  Map<String, dynamic> toJson() => _$HourlyUnitsToJson(this);
}

@JsonSerializable()
class Hourly {
  final List<String> time;
  @JsonKey(name: 'temperature_2m')
  final List<double> temperature2m;
  @JsonKey(name: 'weather_code')
  final List<int> weatherCode;
  @JsonKey(name: 'wind_speed_10m')
  final List<double> windSpeed10m;

  Hourly({
    this.time = const [],
    this.temperature2m = const [],
    this.weatherCode = const [],
    this.windSpeed10m = const [],
  });

  const Hourly.empty()
  : time = const [],
    temperature2m = const [],
    weatherCode = const [],
    windSpeed10m = const [];

  const Hourly.tanuki()
  : time = const [
        "2024-03-03T00:00",
        "2024-03-03T01:00",
        "2024-03-03T02:00",
        "2024-03-03T03:00",
        "2024-03-03T04:00",
        "2024-03-03T05:00",
        "2024-03-03T06:00",
        "2024-03-03T07:00",
        "2024-03-03T08:00",
        "2024-03-03T09:00",
        "2024-03-03T10:00",
        "2024-03-03T11:00",
        "2024-03-03T12:00",
        "2024-03-03T13:00",
        "2024-03-03T14:00",
        "2024-03-03T15:00",
        "2024-03-03T16:00",
        "2024-03-03T17:00",
        "2024-03-03T18:00",
        "2024-03-03T19:00",
        "2024-03-03T20:00",
        "2024-03-03T21:00",
        "2024-03-03T22:00",
        "2024-03-03T23:00"
    ],
    temperature2m = const [
        7.2,
        9.4,
        11.1,
        12.1,
        12.8,
        13.0,
        12.9,
        12.1,
        10.9,
        10.6,
        10.2,
        8.9,
        8.1,
        7.8,
        7.7,
        7.6,
        7.6,
        7.3,
        6.9,
        6.5,
        6.2,
        6.3,
        6.7,
        8.0
    ],
    weatherCode = const [
        0,
        0,
        0,
        0,
        0,
        1,
        1,
        2,
        1,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0
    ],
    windSpeed10m = const [
        13.0,
        13.9,
        11.3,
        15.5,
        17.8,
        16.2,
        17.3,
        12.8,
        10.5,
        6.2,
        6.1,
        8.9,
        11.0,
        12.4,
        13.2,
        13.5,
        12.3,
        9.8,
        7.8,
        7.0,
        6.4,
        7.3,
        7.9,
        6.9
    ];

  factory Hourly.fromJson(Map<String, dynamic> json) => _$HourlyFromJson(json);

  Map<String, dynamic> toJson() => _$HourlyToJson(this);
}

@JsonSerializable()
class DailyUnits {
  final String time;
  @JsonKey(name: 'weather_code')
  final String weatherCode;
  @JsonKey(name: 'temperature_2m_max')
  final String temperature2mMax;
  @JsonKey(name: 'temperature_2m_min')
  final String temperature2mMin;

  DailyUnits({
    this.time = '',
    this.weatherCode = '',
    this.temperature2mMax = '',
    this.temperature2mMin = '',
  });

  const DailyUnits.empty()
  : time = '',
    weatherCode = '',
    temperature2mMax = '',
    temperature2mMin = '';

  const DailyUnits.tanuki()
  : time = "iso8601",
    weatherCode = "wmo code",
    temperature2mMax = "°C",
    temperature2mMin = "°C";

  factory DailyUnits.fromJson(Map<String, dynamic> json) =>
      _$DailyUnitsFromJson(json);

  Map<String, dynamic> toJson() => _$DailyUnitsToJson(this);
}

@JsonSerializable()
class Daily {
  final List<String> time;
  @JsonKey(name: 'weather_code')
  final List<int> weatherCode;
  @JsonKey(name: 'temperature_2m_max')
  final List<double> temperature2mMax;
  @JsonKey(name: 'temperature_2m_min')
  final List<double> temperature2mMin;

  Daily({
    this.time = const [],
    this.weatherCode = const [],
    this.temperature2mMax = const [],
    this.temperature2mMin = const [],
  });

  const Daily.empty()
  : time = const [],
    weatherCode = const [],
    temperature2mMax = const [],
    temperature2mMin = const [];

  const Daily.tanuki()
  : time = const [
        "2024-06-07", "2024-06-08", "2024-06-09", "2024-06-10", "2024-06-11", "2024-06-12", "2024-06-13"
    ],
    weatherCode = const [
        96, 96, 3, 61, 81, 3, 1
    ],
    temperature2mMax = const [
      23.8, 25.4, 21.1, 16.1, 22.8, 16.2, 17.8,
    ],
    temperature2mMin = const [
      16.5, 14.7, 12.1, 12.3, 13.3, 6.7, 2.1,
    ];

  factory Daily.fromJson(Map<String, dynamic> json) => _$DailyFromJson(json);

  Map<String, dynamic> toJson() => _$DailyToJson(this);
}



