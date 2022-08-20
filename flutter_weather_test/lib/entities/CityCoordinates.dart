//координаты и данные города
class CityCoordinates {
  CityCoordinates({
    required this.name,
    required this.localNames,
    required this.lat,
    required this.lon,
    required this.country,
    required this.state,
  });

  String name;
  Map<String, String> localNames;
  double lat;
  double lon;
  String country;
  String state;
}
