import 'dart:convert';
import 'dart:developer' as dev;
import 'package:http/http.dart' as http;
import 'package:weather_final_proj/models/city_class.dart';
import 'package:weather_final_proj/config/env.dart';
import 'package:weather_final_proj/models/weather_data.dart';

enum FetchErrorKind {
  unknown,
  noConnection,
  failedToLoadData,
}

class FetchException implements Exception {
  final String message;
  final FetchErrorKind kind;

  FetchException({required this.message, this.kind = FetchErrorKind.unknown});

  @override
  String toString() {
    return 'GeoFetcherException{kind: $kind, message: $message}';
  }
}



class GeoFetcher {
  // [!] throws
  Future<List<City>> fetchCities(String input, {int count = 10}) async {

    final encodedInput = Uri.encodeComponent(input);
    final encodedCount = Uri.encodeComponent(count.toString());
    final response = await http.get(Uri.parse('https://geocoding-api.open-meteo.com/v1/search?name=$encodedInput&count=$encodedCount&language=en&format=json'));

    if (response.statusCode == 200) {
      dev.log('fetchCitiesSuccess : ${response.statusCode} ${response.reasonPhrase}');
      final data = response.body;
      final json = jsonDecode(data);
      List<dynamic> results; 
      
      if (json['results'] != null && json['results'] is List<dynamic>) {
        results = json['results'] as List<dynamic>;
      } else {
        dev.log('fetchCitiesError : no results found in json data');
        return [];
      }

      final cities = results.map((json) => City.fromJson(json)).toList();

      return cities;
    } else {
      dev.log('[GeoFetcher] fetchCities : ${response.statusCode} ${response.reasonPhrase}');
      throw FetchException(
        message: 'Failed to load data ${response.reasonPhrase}',
        kind: FetchErrorKind.failedToLoadData,
      );
    }
  }

  Future<City> fetchCityByCoordinates(double lat, double long) async {
    final City city;

    try {
      final cityName = await _fetchCityNameByCoordinates(lat, long);
      if (cityName.isNotEmpty) {
        try {
          final cities = await fetchCities(cityName, count: 1);
          city = cities[0];
        } catch (e) {
          dev.log('fetchCityByCoordinatesError : ${e.toString()}}');
          throw Exception(e.toString());
        }
      } else {
        city = City.unknownCity(latitude: lat, longitude: long);
      }

      return city;
     
    } catch (e) {
      dev.log('fetchCityByCoordinatesError : ${e.toString()}}');
      throw Exception('[GeoFetcher][fetchCityByCoordinates] Failed to load data ${e.toString()}');
    }
  }

  // private
  Future<String> _fetchCityNameByCoordinates(double lat, double long) async {
    const baseUrl = 'https://api.openweathermap.org/geo/1.0/reverse';
    final apiKey = Env.weatherOrgApiKey;

    final params = <String, String>{
      'lat': lat.toString(),
      'lon': long.toString(),
      'limit': '1',
      'appid': apiKey,
    };

    // The encodeComponent is handled in the replace method
    final uri = Uri.parse(baseUrl).replace(queryParameters: params);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      try {
        final data = response.body;
        final json = jsonDecode(data);
        final cityName = json[0]['name'] as String;
        return cityName;

      } catch (e) {
        dev.log('_fetchCityNameByCoordinates no city name found: ${e.toString()}');
        return "";
      }
    } else {
      dev.log('_fetchCityNameByCoordinates : ${response.statusCode} ${response.reasonPhrase}');
      throw Exception('[GeoFetcher][_fetchCityNameByCoordinates] Failed to load data ${response.reasonPhrase}');
    }
  }



  // [!] throws
  // to get the forecast for a specific location
  // GET (forecast) https://api.open-meteo.com/v1/forecast?latitude=52.52437&longitude=13.41053&current_weather=true
  Future<WeatherData> fetchForecastForCity(City city) async {
    const baseUrl = 'https://api.open-meteo.com/v1/forecast';
    final WeatherData weatherData;

    final params = <String, Object> {
      'latitude': city.latitude.toString(),
      'longitude': city.longitude.toString(),
      'current_weather': 'true',
      "hourly": ["temperature_2m", "weather_code", "wind_speed_10m"],
      "daily": ["weather_code", "temperature_2m_max", "temperature_2m_min"],
      "timezone": "Europe/London",
      "forecast_days": "7",
    };

    final uri = Uri.parse(baseUrl).replace(queryParameters: params);
    dev.log('fetchForecastForCity uri : $uri');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      dev.log('fetchForecastForCitySuccess : ${response.statusCode} ${response.reasonPhrase}');
      
      // DEBUG ONLY - CHECK
      // final String body = response.body;
      // dev.log('fetchForecastForCity response.body : $body');
      try {

      final jsonMap = json.decode(response.body);
      final WeatherData fetchedWeaver = WeatherData.fromJson(jsonMap);

      // DEBUG ONLY - CHECK
      dev.log('city.name(not from json): ${city.name}');
      dev.log('latitude =  : ${fetchedWeaver.latitude}');
      dev.log('longitude =  : ${fetchedWeaver.longitude}');
      // dev.log('fetchedWeaver.generationtimeMs =  : ${fetchedWeaver.generationtimeMs}');
      dev.log('currentWeather.temperature =  : ${fetchedWeaver.currentWeather.temperature}');
      dev.log('currentWeather.windspeed =  : ${fetchedWeaver.currentWeather.windspeed}');
      // dev.log('hourly.temperature2m =  : ${fetchedWeaver.hourly.temperature2m}');
      // dev.log('hourly.time =  : ${fetchedWeaver.hourly.time}');
    
      weatherData = fetchedWeaver;
      } catch (e) {
        dev.log('fetchForecastForCityError : ${e.toString()}');
        throw Exception(e.toString());
      }
    } else {
      dev.log('fetchForecastForCityError : ${response.statusCode} ${response.reasonPhrase}');
      throw Exception('Failed to load data ${response.reasonPhrase}');
    }

    return weatherData;
  }


}