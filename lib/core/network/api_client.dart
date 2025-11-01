import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ticket_booking/core/constants/api_endpoints.dart';

class ApiClient {
  final http.Client _client;

  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  // get

  Future<dynamic> get(String path) async {
    final url = Uri.parse('${ApiEndpoints.baseUrl}$path');
    final res = await _client.get(url);
    if (res.statusCode >= 200 && res.statusCode < 300) {
      return json.decode(res.body);
    }
    throw Exception('Network error: \${res.statusCode}');
  }

  // add new user

  Future<dynamic> post(String path, Map<String, dynamic> body) async {
    final url = Uri.parse('${ApiEndpoints.baseUrl}$path');
    final res = await _client
        .post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode(body),
        )
        .timeout(const Duration(seconds: 30));

    if (res.statusCode >= 200 && res.statusCode < 300) {
      return json.decode(res.body);
    }
    throw Exception('POST failed: ${res.statusCode}');
  }

  // For completeness we could add post/put/delete here
}
