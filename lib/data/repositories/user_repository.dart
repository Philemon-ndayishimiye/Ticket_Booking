
import 'package:ticket_booking/core/network/api_client.dart';
import 'package:ticket_booking/core/constants/api_endpoints.dart';
import 'package:ticket_booking/data/models/user_model.dart';
import 'package:ticket_booking/core/services/storage_service.dart';
class UserRepository {
final ApiClient apiClient;
final StorageService storageService; 
UserRepository(this.apiClient, this.storageService);


// NOTE: dummyjson has an auth endpoint that expects username/password; for simplicity we simulate.
// Future<UserModel> login({required String username, required String password}) async {
// In real app: call the login endpoint
// final res = await apiClient.post('/auth/login', body: {...});


// Simulate successful login for any non-empty credentials
// await Future.delayed(const Duration(milliseconds: 400));
// return UserModel(id: 1, username: username);
// }

// login function

Future<UserModel> login({required String username, required String password}) async {
  final res = await apiClient.post(ApiEndpoints.login, {
    'username': username,
    'password': password,
    'expiresInMins': 30,
  });

  // Dummyjson returns user fields at root, not inside 'user'
  final user = UserModel.fromJson(res);

  // Save token and userId
  final token = res['token'];
  if (token != null) {
    await storageService.saveToken(token);
    await storageService.saveUserId(user.id ?? 0);
  }

  return user;
}


  // New method: add user to backend
  Future<UserModel> createUser({
    required String firstName,
    required String lastName,
    required int age,
  }) async {
    final res = await apiClient.post(ApiEndpoints.addUser, {
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
    });
    return UserModel.fromJson(res);
  }
}