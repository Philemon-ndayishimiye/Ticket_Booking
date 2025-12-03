import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ticket_booking/core/constants/api_endpoints.dart';
import 'package:ticket_booking/core/services/storage_service.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ApiClient {
  final http.Client _client;
  final StorageService storageService;

  ApiClient({required this.storageService, http.Client? client})
      : _client = client ?? http.Client();

  // ---------- GET ----------
  Future<dynamic> get(String path, {bool useToken = true}) async {
    final url = Uri.parse('${ApiEndpoints.baseUrl}$path');
    print('🔹 [GET] $url');

    if (useToken) {
      await _ensureTokenValid(); // ✅ Ensure token is valid before request
    }

    final token = storageService.readToken();
    final headers = {
      'Content-Type': 'application/json',
      if (useToken && token != null) 'Authorization': 'Bearer $token',
    };

    print('🔹 [HEADERS]: $headers');

    final res = await _client.get(url, headers: headers);

    print('🔸 [RESPONSE CODE]: ${res.statusCode}');
    print('🔸 [RESPONSE BODY]: ${res.body}');

    if (res.statusCode >= 200 && res.statusCode < 300) {
      return _safeJsonDecode(res.body);
    } else {
      final message = _extractErrorMessage(res);
      throw Exception('GET failed [${res.statusCode}]: $message');
    }
  }

  // ---------- POST ----------
  Future<dynamic> post(
    String path,
    Map<String, dynamic> body, {
    bool auth = true,
  }) async {
    final url = Uri.parse('${ApiEndpoints.baseUrl}$path');

    if (auth) await _ensureTokenValid(); // ✅ refresh token if needed

    final token = auth ? storageService.readToken() : null;
    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    print('🔹 [POST] $url');
    print('🔹 [HEADERS]: $headers');
    print('🔹 [BODY]: ${json.encode(body)}');

    final res = await _client.post(url, headers: headers, body: json.encode(body));

    print('🔸 [STATUS CODE]: ${res.statusCode}');
    print('🔸 [RESPONSE BODY]: ${res.body}');

    if (res.statusCode >= 200 && res.statusCode < 300) {
      return _safeJsonDecode(res.body);
    } else {
      final message = _extractErrorMessage(res);
      throw Exception('POST failed [${res.statusCode}]: $message');
    }
  }

  // ---------- PATCH ----------
  Future<dynamic> patch(String path, Map<String, dynamic> body) async {
    final url = Uri.parse('${ApiEndpoints.baseUrl}$path');

    await _ensureTokenValid(); // ✅ refresh token if needed
    final token = storageService.readToken();

    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    print('🔹 [PATCH] $url');
    print('🔹 [HEADERS]: $headers');
    print('🔹 [BODY]: ${json.encode(body)}');

    final res = await _client.patch(url, headers: headers, body: json.encode(body));

    print('🔸 [STATUS CODE]: ${res.statusCode}');
    print('🔸 [RESPONSE BODY]: ${res.body}');

    if (res.statusCode >= 200 && res.statusCode < 300) {
      return _safeJsonDecode(res.body);
    } else {
      final message = _extractErrorMessage(res);
      throw Exception('PATCH failed [${res.statusCode}]: $message');
    }
  }

  // ---------- PRIVATE ----------

  Future<void> _ensureTokenValid() async {
    final accessToken = storageService.readToken();
    final refreshToken = storageService.readRefreshToken();

    if (accessToken == null) {
      throw Exception("No access token. Login required.");
    }

    if (JwtDecoder.isExpired(accessToken)) {
      if (refreshToken == null) {
        throw Exception("Refresh token missing. Login required.");
      }

      final url = Uri.parse('${ApiEndpoints.baseUrl}/auth/refresh/');
      final res = await _client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'refresh': refreshToken}),
      );

      if (res.statusCode >= 200 && res.statusCode < 300) {
        final data = json.decode(res.body);
        final newAccessToken = data['access'];
        if (newAccessToken != null) {
          await storageService.saveToken(newAccessToken);
        }
      } else {
        await storageService.clearToken();
        await storageService.clearRefreshToken();
        throw Exception("Token refresh failed. Login required.");
      }
    }
  }

  dynamic _safeJsonDecode(String body) {
    try {
      return json.decode(body);
    } catch (_) {
      return body;
    }
  }

  String _extractErrorMessage(http.Response res) {
    try {
      final decoded = json.decode(res.body);

      if (decoded is Map<String, dynamic>) {
        if (decoded.containsKey('message')) return decoded['message'].toString();
        if (decoded.containsKey('error')) return decoded['error'].toString();

        if (decoded.values.any((v) => v is List)) {
          final firstError = decoded.entries
              .map((e) => "${e.key}: ${(e.value as List).join(', ')}")
              .join(' | ');
          return firstError;
        }

        return decoded.toString();
      }

      return res.body;
    } catch (_) {
      return res.body;
    }
  }
}
