import 'dart:convert';

import '../models/character.dart';
import '../utils/api_client.dart';

class CharactersRepository {
  final ApiClient apiClient;

  CharactersRepository({required this.apiClient});

  Future<List<Character>> fetchCharacters() async {
    final response = await apiClient.get('people');
    final List<dynamic> charactersJson = json.decode(response.body);

    return charactersJson.map((json) => Character.fromJson(json)).toList();
  }

  Future<Character> fetchCharacterDetails(String id) async {
    final response = await apiClient.get('people/$id');
    final Map<String, dynamic> characterJson = json.decode(response.body);

    return Character.fromJson(characterJson);
  }

  Future<List<Character>> fetchCharactersByIds(List<String> ids) async {
    var futures = <Future<Character>>[];

    for (String id in ids) {
      futures.add(fetchCharacterDetails(id));
    }

    var characters = await Future.wait(futures, eagerError: true);

    return characters;
  }

  Future<List<Character>> fetchCharactersByUrls(List<String> urls) async {
    var futures = <Future<Character>>[];

    for (String url in urls) {
      if (url == "https://ghibliapi.vercel.app/people/") {
        continue;
      }
      futures.add(fetchCharacterByUrl(url));
    }

    var characters = await Future.wait(futures, eagerError: true);

    return characters;
  }

  Future<Character> fetchCharacterByUrl(String url) async {
    if (url == "https://ghibliapi.vercel.app/people/") {
      return Character(id: "0", name: "Not Specified", gender: "Not Specified",
          age: "Not Specified", eyeColor: "eyeColor", hairColor: "hairColor",
          films: ["films"], species: "species", url: "url");
    }
    final response = await apiClient.get(url);
    final Map<String, dynamic> characterJson = json.decode(response.body);

    return Character.fromJson(characterJson);
  }
}