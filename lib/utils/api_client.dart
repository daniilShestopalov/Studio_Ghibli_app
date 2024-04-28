import 'package:http/http.dart' as http;

class ApiClient {
  final baseUrl = "https://ghibliapi.vercel.app";

  Future<http.Response> get(String endpoint) async {
    final uri = Uri.parse(endpoint).isAbsolute
        ? Uri.parse(endpoint)
        : Uri.parse('$baseUrl/$endpoint');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
