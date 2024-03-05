import 'dart:developer' as dev;

typedef VoidCallback = void Function();

class CityError extends Error {
  final String message;
  final VoidCallback onTap;

  CityError({required this.message, required this.onTap});

}

class City {
  final int id;
  final String name;
  final double latitude;
  final double longitude;
  final String region;
  final String countryCode;
  final int countryId;
  final String country;

  City({
    required this.id,
    this.name = '',
    required this.latitude,
    required this.longitude,
    this.region = '',
    this.countryCode = '',
    this.countryId = 0,
    this.country = '',
  });

  City.unknownCity({
    required this.latitude,
    required this.longitude,
  })  : id = 0,
        name = 'Unknown',
        region = 'Unknown',
        countryCode = 'Unknown',
        countryId = 0,
        country = 'Unknown';

  City.tanukiCity()
  : id = 1849899,
    latitude = 32.5,
    longitude = 131.68333,
    name = 'Totoro',
    region = 'Happy Region',
    countryCode = 'JP',
    countryId = 1861060,
    country = 'Japan';

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      region: json['admin1'] as String? ?? '',
      countryCode: json['country_code'] as String? ?? '',
      countryId: json['country_id'] as int? ?? 0,
      country: json['country'] as String? ?? '',
    );
  }

  static List<City> getSampleData() {
    return [
      City(id: 1, name: 'Paris', latitude: 48.8566, longitude: 2.3522, region: 'Île-de-France', countryCode: 'FR', countryId: 1, country: 'France'),
      City(id: 2, name: 'London', latitude: 51.5074, longitude: -0.1278, region: 'Greater London', countryCode: 'UK', countryId: 2, country: 'United Kingdom'),
      City(id: 3, name: 'New York', latitude: 40.7128, longitude: -74.0060, region: 'New York State', countryCode: 'US', countryId: 3, country: 'United States'),
      City(id: 4, name: 'Berlin', latitude: 52.5200, longitude: 13.4050, region: 'Berlin', countryCode: 'DE', countryId: 4, country: 'Germany'),
      City(id: 5, name: 'Madrid', latitude: 40.4168, longitude: -3.7038, region: 'Community of Madrid', countryCode: 'ES', countryId: 5, country: 'Spain'),
      City(id: 6, name: 'Rome', latitude: 41.9028, longitude: 12.4964, region: 'Lazio', countryCode: 'IT', countryId: 6, country: 'Italy'),
      City(id: 7, name: 'Moscow', latitude: 55.7558, longitude: 37.6176, region: 'Central Federal District', countryCode: 'RU', countryId: 7, country: 'Russia'),
      City(id: 8, name: 'Beijing', latitude: 39.9042, longitude: 116.4074, region: 'Beijing', countryCode: 'CN', countryId: 8, country: 'China'),
      City(id: 9, name: 'Tokyo', latitude: 35.6895, longitude: 139.6917, region: 'Tokyo', countryCode: 'JP', countryId: 9, country: 'Japan'),
      City(id: 10, name: 'Sydney', latitude: -33.8688, longitude: 151.2093, region: 'New South Wales', countryCode: 'AU', countryId: 10, country: 'Australia'),
  ];
  }
}
