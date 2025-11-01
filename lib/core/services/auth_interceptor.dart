import 'package:dio/dio.dart';
import 'package:ticket_booking/core/services/storage_service.dart';
import 'package:ticket_booking/core/utils/logger.dart';
import 'package:ticket_booking/injection.dart' as di;

// Attaches Authorization header to each request if token exists
class AuthInterceptor extends Interceptor {
  final StorageService _storageService = di.SimpleDI.storageService;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = _storageService.readToken(); // ✅ use readToken()
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
      appLogger.i('AuthInterceptor: attached token to request');
    }
    handler.next(options);
  }
}
