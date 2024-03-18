# Weather App

*A Flutter project focused on mobile **structure and logic**, **Api handling** and **UI/UX**.*

---

| Current weather | Daily weather | Weekly weather |
| --- | --- | --- |
| ![Image 1](.screenshots/currently.png) | ![Image 2](.screenshots/daily.png) | ![Image 3](.screenshots/weekly.png) |


## Geolocalisation

- [geolocator dart package](https://pub.dev/packages/geolocator)




## NEXT STEPS
- API call [Fetch data from the internet - official flutter](https://docs.flutter.dev/cookbook/networking/fetch-data)
- API1 Geocoding -> get coordinates + ciies from a name/searchinput open-meteo [API](https://open-meteo.com/en/docs/geocoding-api)
- Flutter [InheritedWidget](https://api.flutter.dev/flutter/widgets/InheritedWidget-class.html) class -> conclusion use [Provider](https://pub.dev/packages/provider) instead
- Provider [Video](https://www.youtube.com/watch?v=FUDhozpnTUw)
- API2 Reverse geocoding **openweathermap** from [coordinates](https://openweathermap.org/api/geocoding-api)
- Make API **key** for **openweathermap** need make free account
- Put **API Key in .env** then access into flutter [cet article semble bien](https://dev.to/namankk/securely-storing-api-keys-in-flutter-3ko4) (envied 3 packages) 
- forecastAPI -> lot of data to serialize with json package + files to generate with `flutter pub run build_runner build`
- connectivity (check if connected to a network) package + need line to add to manifest for emulator enable access
- fl_chart package (temp charts)


| Coordinates from device GPS | Browse city names through an Api |
| --- | --- |
| ![Image 1](.screenshots/gps.png) | ![Image 2](.screenshots/search.png) |