import 'dart:convert';
import '../models/vehicle.dart';
import '../utils/api_client.dart';

class VehiclesRepository {
  final ApiClient apiClient;

  VehiclesRepository({required this.apiClient});

  Future<List<Vehicle>> fetchVehicles() async {
    final response = await apiClient.get('vehicles');
    final List<dynamic> vehiclesJson = json.decode(response.body);

    return vehiclesJson.map((json) => Vehicle.fromJson(json)).toList();
  }

  Future<Vehicle> fetchVehicleDetails(String id) async {
    final response = await apiClient.get('vehicles/$id');
    final Map<String, dynamic> vehicleJson = json.decode(response.body);

    return Vehicle.fromJson(vehicleJson);
  }

  Future<List<Vehicle>> fetchVehiclesByIds(List<String> ids) async {
    var futures = <Future<Vehicle>>[];

    for (String id in ids) {
      futures.add(fetchVehicleDetails(id));
    }

    var vehicles = await Future.wait(futures, eagerError: true);

    return vehicles;
  }

  Future<List<Vehicle>> fetchVehiclesByUrls(List<String> urls) async {
    var futures = <Future<Vehicle>>[];

    for (String url in urls) {
      futures.add(fetchVehicleByUrl(url));
    }

    var vehicles = await Future.wait(futures, eagerError: true);

    return vehicles;
  }

  Future<Vehicle> fetchVehicleByUrl(String url) async {
    final response = await apiClient.get(url);
    final Map<String, dynamic> vehicle = json.decode(response.body);

    return Vehicle.fromJson(vehicle);
  }
}