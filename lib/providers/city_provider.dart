import 'package:flutter/material.dart';
import 'package:weather_final_proj/models/city_class.dart';
import 'package:weather_final_proj/models/weather_data.dart';

class CityProvider extends ChangeNotifier {
  List<City> suggestionsCities;
  bool shouldDisplay;
  bool shouldResignFocus;
  bool keyboardIsUp;
  String searchInput;
  City? selectedCity;
  CityError? error;
  WeatherData weatherData;

  CityProvider()
  : suggestionsCities = [],
    shouldDisplay = false,
    shouldResignFocus = false,
    searchInput = "",
    keyboardIsUp = false,
    weatherData = const WeatherData.tanukiWeather();

  WeatherData get getWeatherData => weatherData;

  void update(List<City> cities, String input) {
    suggestionsCities = cities;
    shouldDisplay = true;
    searchInput = input;
    if (cities.isNotEmpty) {
      error = null;
    }
    notifyListeners();
  }

  void updateKeyboardStatus(bool status) {
    keyboardIsUp = status;
    notifyListeners();
  }

  void updateWeatherData(WeatherData data) {
    weatherData = data;
    notifyListeners();
  }

  void targetCity(City city) {
    selectedCity = city;
    shouldResignFocus = true;
    clear();
  }

  void setError(String errorMesage) {
    error = CityError(message: errorMesage, onTap: () {
      error = null;
      notifyListeners();
    });
    notifyListeners();
  }

  void clear() {
    suggestionsCities.clear();
    shouldDisplay = false;
    searchInput = "";
    notifyListeners();
  }

  void cancelingInput(String value) {
    shouldDisplay = false;
    suggestionsCities.clear();
    searchInput = value;
    notifyListeners();
  }

  void submitCityByName(value) {
    if (suggestionsCities.isNotEmpty) {
      submitCity(suggestionsCities[0]); 
    } else {
      error = CityError(message: "No city found with name: $value", onTap: 
      () {
        error = null;
        notifyListeners();
      });
      clear();
    }
  }

  void submitCity(City city) {
    selectedCity = city;
    shouldResignFocus = true;
    clear();
  }

  

}