import 'dart:convert';
import '../models/location.dart';
import '../utils/api_client.dart';

class LocationsRepository {
  final ApiClient apiClient;

  LocationsRepository({required this.apiClient});

  Future<List<Location>> fetchLocations() async {
    final response = await apiClient.get('locations');
    final List<dynamic> locationsJson = json.decode(response.body);

    return locationsJson.map((json) => Location.fromJson(json)).toList();
  }

  Future<Location> fetchLocationDetails(String id) async {
    final response = await apiClient.get('locations/$id');
    final Map<String, dynamic> locationJson = json.decode(response.body);

    return Location.fromJson(locationJson);
  }

  Future<List<Location>> fetchLocationsByIds(List<String> ids) async {
    var futures = <Future<Location>>[];

    for (String id in ids) {
      futures.add(fetchLocationDetails(id));
    }

    var locations = await Future.wait(futures, eagerError: true);

    return locations;
  }

  Future<List<Location>> fetchLocationsByUrls(List<String> urls) async {
    var futures = <Future<Location>>[];

    for (String url in urls) {
      futures.add(fetchLocationByUrl(url));
    }

    var locations = await Future.wait(futures, eagerError: true);

    return locations;
  }

  Future<Location> fetchLocationByUrl(String url) async {
    final response = await apiClient.get(url);
    final Map<String, dynamic> locationJson = json.decode(response.body);

    return Location.fromJson(locationJson);
  }
}