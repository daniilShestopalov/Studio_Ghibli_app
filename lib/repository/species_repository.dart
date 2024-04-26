import 'dart:convert';
import '../models/species.dart';
import '../utils/api_client.dart';

class SpeciesRepository {
  final ApiClient apiClient;

  SpeciesRepository({required this.apiClient});

  Future<List<Species>> fetchSpecies() async {
    final response = await apiClient.get('species');
    final List<dynamic> speciesJson = json.decode(response.body);

    return speciesJson.map((json) => Species.fromJson(json)).toList();
  }

  Future<Species> fetchSpeciesDetails(String id) async {
    final response = await apiClient.get('species/$id');
    final Map<String, dynamic> speciesJson = json.decode(response.body);

    return Species.fromJson(speciesJson);
  }

  Future<List<Species>> fetchSpeciesByIds(List<String> ids) async {
    var futures = <Future<Species>>[];

    for (String id in ids) {
      futures.add(fetchSpeciesDetails(id));
    }

    var species = await Future.wait(futures, eagerError: true);

    return species;
  }

  Future<List<Species>> fetchSpeciesByUrls(List<String> urls) async {
    var futures = <Future<Species>>[];

    for (String url in urls) {
      futures.add(fetchSpeciesByUrl(url));
    }

    var species = await Future.wait(futures, eagerError: true);

    return species;
  }

  Future<Species> fetchSpeciesByUrl(String url) async {
    final response = await apiClient.get(url);
    final Map<String, dynamic> speciesJson = json.decode(response.body);

    return Species.fromJson(speciesJson);
  }
}