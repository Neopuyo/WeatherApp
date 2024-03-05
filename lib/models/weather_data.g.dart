// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherData _$WeatherDataFromJson(Map<String, dynamic> json) => WeatherData(
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      generationtimeMs: (json['generationtime_ms'] as num?)?.toDouble() ?? 0.0,
      utcOffsetSeconds: json['utc_offset_seconds'] as int? ?? 0,
      timezone: json['timezone'] as String? ?? '',
      timezoneAbbreviation: json['timezone_abbreviation'] as String? ?? '',
      elevation: (json['elevation'] as num?)?.toDouble() ?? 9999.0,
      currentWeatherUnits: json['current_weather_units'] == null
          ? const CurrentWeatherUnits.empty()
          : CurrentWeatherUnits.fromJson(
              json['current_weather_units'] as Map<String, dynamic>),
      currentWeather: json['current_weather'] == null
          ? const CurrentWeather.empty()
          : CurrentWeather.fromJson(
              json['current_weather'] as Map<String, dynamic>),
      hourlyUnits: json['hourly_units'] == null
          ? const HourlyUnits.empty()
          : HourlyUnits.fromJson(json['hourly_units'] as Map<String, dynamic>),
      hourly: json['hourly'] == null
          ? const Hourly.empty()
          : Hourly.fromJson(json['hourly'] as Map<String, dynamic>),
      dailyUnits: json['daily_units'] == null
          ? const DailyUnits.empty()
          : DailyUnits.fromJson(json['daily_units'] as Map<String, dynamic>),
      daily: json['daily'] == null
          ? const Daily.empty()
          : Daily.fromJson(json['daily'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WeatherDataToJson(WeatherData instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'generationtime_ms': instance.generationtimeMs,
      'utc_offset_seconds': instance.utcOffsetSeconds,
      'timezone': instance.timezone,
      'timezone_abbreviation': instance.timezoneAbbreviation,
      'elevation': instance.elevation,
      'current_weather_units': instance.currentWeatherUnits,
      'current_weather': instance.currentWeather,
      'hourly_units': instance.hourlyUnits,
      'hourly': instance.hourly,
      'daily_units': instance.dailyUnits,
      'daily': instance.daily,
    };

CurrentWeatherUnits _$CurrentWeatherUnitsFromJson(Map<String, dynamic> json) =>
    CurrentWeatherUnits(
      time: json['time'] as String? ?? '',
      interval: json['interval'] as String? ?? '',
      temperature: json['temperature'] as String? ?? '',
      windspeed: json['windspeed'] as String? ?? '',
      winddirection: json['winddirection'] as String? ?? '',
      isDay: json['is_day'] as String? ?? '',
      weathercode: json['weathercode'] as String? ?? '',
    );

Map<String, dynamic> _$CurrentWeatherUnitsToJson(
        CurrentWeatherUnits instance) =>
    <String, dynamic>{
      'time': instance.time,
      'interval': instance.interval,
      'temperature': instance.temperature,
      'windspeed': instance.windspeed,
      'winddirection': instance.winddirection,
      'is_day': instance.isDay,
      'weathercode': instance.weathercode,
    };

CurrentWeather _$CurrentWeatherFromJson(Map<String, dynamic> json) =>
    CurrentWeather(
      time: json['time'] as String? ?? '',
      interval: json['interval'] as int? ?? 0,
      temperature: (json['temperature'] as num?)?.toDouble() ?? 0.0,
      windspeed: (json['windspeed'] as num?)?.toDouble() ?? 0.0,
      winddirection: json['winddirection'] as int? ?? 0,
      isDay: json['is_day'] as int? ?? 0,
      weathercode: json['weathercode'] as int? ?? 0,
    );

Map<String, dynamic> _$CurrentWeatherToJson(CurrentWeather instance) =>
    <String, dynamic>{
      'time': instance.time,
      'interval': instance.interval,
      'temperature': instance.temperature,
      'windspeed': instance.windspeed,
      'winddirection': instance.winddirection,
      'is_day': instance.isDay,
      'weathercode': instance.weathercode,
    };

HourlyUnits _$HourlyUnitsFromJson(Map<String, dynamic> json) => HourlyUnits(
      time: json['time'] as String? ?? '',
      temperature2m: json['temperature_2m'] as String? ?? '',
      weatherCode: json['weatherCode'] as String? ?? '',
      windSpeed10m: json['wind_speed_10m'] as String? ?? '',
    );

Map<String, dynamic> _$HourlyUnitsToJson(HourlyUnits instance) =>
    <String, dynamic>{
      'time': instance.time,
      'temperature_2m': instance.temperature2m,
      'weatherCode': instance.weatherCode,
      'wind_speed_10m': instance.windSpeed10m,
    };

Hourly _$HourlyFromJson(Map<String, dynamic> json) => Hourly(
      time:
          (json['time'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      temperature2m: (json['temperature_2m'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          const [],
      weatherCode: (json['weather_code'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          const [],
      windSpeed10m: (json['wind_speed_10m'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          const [],
    );

Map<String, dynamic> _$HourlyToJson(Hourly instance) => <String, dynamic>{
      'time': instance.time,
      'temperature_2m': instance.temperature2m,
      'weather_code': instance.weatherCode,
      'wind_speed_10m': instance.windSpeed10m,
    };

DailyUnits _$DailyUnitsFromJson(Map<String, dynamic> json) => DailyUnits(
      time: json['time'] as String? ?? '',
      weatherCode: json['weather_code'] as String? ?? '',
      temperature2mMax: json['temperature_2m_max'] as String? ?? '',
      temperature2mMin: json['temperature_2m_min'] as String? ?? '',
    );

Map<String, dynamic> _$DailyUnitsToJson(DailyUnits instance) =>
    <String, dynamic>{
      'time': instance.time,
      'weather_code': instance.weatherCode,
      'temperature_2m_max': instance.temperature2mMax,
      'temperature_2m_min': instance.temperature2mMin,
    };

Daily _$DailyFromJson(Map<String, dynamic> json) => Daily(
      time:
          (json['time'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      weatherCode: (json['weather_code'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          const [],
      temperature2mMax: (json['temperature_2m_max'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          const [],
      temperature2mMin: (json['temperature_2m_min'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          const [],
    );

Map<String, dynamic> _$DailyToJson(Daily instance) => <String, dynamic>{
      'time': instance.time,
      'weather_code': instance.weatherCode,
      'temperature_2m_max': instance.temperature2mMax,
      'temperature_2m_min': instance.temperature2mMin,
    };
