import 'package:http/http.dart' as http;

class ApiClient {
  final baseUrl = "https://ghibliapi.vercel.app";

  Future<http.Response> get(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'));
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
