import 'dart:convert';
import '../models/film.dart';
import '../utils/api_client.dart';

class FilmsRepository {
  final ApiClient apiClient;

  FilmsRepository({required this.apiClient});

  Future<List<Film>> fetchFilms() async {
    final response = await apiClient.get('films');
    final List<dynamic> filmsJson = json.decode(response.body);

    return filmsJson.map((json) => Film.fromJson(json)).toList();
  }

  Future<Film> fetchFilmDetails(String id) async {
    final response = await apiClient.get('films/$id');
    final Map<String, dynamic> filmJson = json.decode(response.body);

    return Film.fromJson(filmJson);
  }

  Future<List<Film>> fetchFilmsByIds(List<String> ids) async {
    var futures = <Future<Film>>[];

    for (String id in ids) {
      futures.add(fetchFilmDetails(id));
    }

    var films = await Future.wait(futures, eagerError: true);

    return films;
  }

  Future<List<Film>> fetchFilmsByUrls(List<String> urls) async {
    var futures = <Future<Film>>[];

    for (String url in urls) {
      if (url == "https://ghibliapi.vercel.app/films/") {
        continue;
      }
      futures.add(fetchFilmDetails(url));
    }

    var films = await Future.wait(futures, eagerError: true);

    return films;
  }

  Future<Film> fetchFilmByUrl(String url) async {
    final response = await apiClient.get(url);
    final Map<String, dynamic> filmJson = json.decode(response.body);

    return Film.fromJson(filmJson);
  }

}