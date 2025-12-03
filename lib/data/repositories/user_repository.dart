// import 'dart:ffi';
import 'package:ticket_booking/data/models/complete_profile_model.dart';
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
  Future<RegisterUserModel> login({
    required String email,
    required String password,
  }) async {
    // Clear old tokens before login
    await storageService.clearToken();
    await storageService.clearUserId();

    // Send login request WITHOUT attaching old token
    final res = await apiClient.post(ApiEndpoints.login, {
      'email': email,
      'password': password,
    }, auth: false);

    // Parse response
    final user = RegisterUserModel.fromJson(res);

    // Save new tokens and user ID
    if (user.access != null) {
      await storageService.saveToken(user.access!);
    }

    // save refresh token

    // Save new refresh token
    if (user.refresh != null) {
      await storageService.saveRefreshToken(user.refresh!);
    }

    if (user.user?.id != null) {
      await storageService.saveUserId(user.user!.id!);
    }

    return user;
  }

  // update user account
  Future<CompleteProfile> updateUserProfile({
    required String fullName,
    required String gender,
    required String phone,
    required String country,
    required String birthDate,
  }) async {
    final body = {
      "full_name": fullName,
      "gender": gender,
      "phone": phone,
      "your_country": country,
      "birth_date": birthDate,
    };

    final res = await apiClient.patch(ApiEndpoints.updateaccount, body);

    // Ensure res is a Map
    final Map<String, dynamic> resMap = Map<String, dynamic>.from(res);

    // Check status instead of success
    if (resMap["status"] != "success") {
      throw Exception(
        "Failed to update profile: ${resMap['message'] ?? 'Unknown error'}",
      );
    }

    final data = Map<String, dynamic>.from(resMap['data']);
    return CompleteProfile.fromJson(data);
  }

  // Get Complete Profile using access token
  Future<CompleteProfile> getCompleteProfile() async {
    try {
      final res = await apiClient.get(ApiEndpoints.completeProfile);

      if (res == null || res is! Map) {
        throw Exception("API returned invalid response: $res");
      }

      final Map<String, dynamic> resMap = Map<String, dynamic>.from(res);

      //  Correct key check
      if (resMap["status"] != "success") {
        throw Exception(
          "Failed to load profile: ${resMap['message'] ?? 'Unknown error'}",
        );
      }

      final data = resMap['data'];
      if (data == null || data is! Map) {
        throw Exception("Profile data missing or invalid: $data");
      }

      final profileData = data['profile'] != null
          ? Map<String, dynamic>.from(data['profile'])
          : null;

      final completeProfile = CompleteProfile.fromJson({
        ...Map<String, dynamic>.from(data),
        'profile': profileData,
      });

      print(" Complete profile parsed: ${completeProfile.fullName}");
      return completeProfile;
    } catch (e, st) {
      print(" Error in getCompleteProfile: $e\n$st");
      rethrow;
    }
  }

  // get user by id

  Future<User> singleUser({required int id}) async {
    // Construct path exactly as swagger shows:
    // If ApiEndpoints.singleuser == '/auth/user'
    final path = '${ApiEndpoints.singleuser}/$id/get_user/';

    final resp = await apiClient.get(path);

    // Handle response shapes:
    if (resp is Map<String, dynamic>) {
      // Some APIs return { "data": { ... } }
      final payload = resp['data'] is Map<String, dynamic>
          ? resp['data'] as Map<String, dynamic>
          : resp;
      return User.fromJson(payload);
    }

    throw Exception('Unexpected response format for singleUser: $resp');
  }

  // request otp
  Future<void> requestOtp({required String email}) async {
    final body = {"email": email};
    // Remove null values — some backends reject null/empty keys
    body.removeWhere((key, value) => value == null || value == '');
    await apiClient.post(ApiEndpoints.requestOtp, body);
  }

  // logout
  Future<void> logout() async {
    try {
      // Call your backend logout endpoint
      await apiClient.post(ApiEndpoints.logout, {});

      // Clear local storage tokens
      await storageService.clearToken();
      await storageService.clearUserId();

      // Optionally clear other cached user info
    } catch (e) {
      // Handle error if needed
      print('Logout failed: $e');
    }
  }

  // reset password with otp

  Future<void> resetpassword({
    required String otp_code,
    required String email,
    required String new_password,
    required String confirm_password,
  }) async {
    final body = {
      "otp_code": otp_code,
      "email": email,
      "new_password": new_password,
      "confirm_password": confirm_password,
    };
    // Remove null values — some backends reject null/empty keys
    body.removeWhere((key, value) => value == null || value == '');
    await apiClient.post(ApiEndpoints.resetpassword, body);
  }

  // New method: add user to backend
  Future<void> createUser({
    required String email,
    required String password,
    required String password_confirm,
    String? full_name,
    String? phone,
    String? your_country,
    String? gender,
    String? birth_date,
  }) async {
    final body = {
      "email": email,
      "password": password,
      "password_confirm": password_confirm,
      "full_name": full_name,
      "phone": phone,
      "your_country": your_country,
      "gender": gender,
      "birth_date": birth_date,
    };

    // Remove null values — some backends reject null/empty keys
    body.removeWhere((key, value) => value == null || value == '');

    final response = await apiClient.post(ApiEndpoints.register, body);
    // optionally save tokens here if backend returns them
  }
}
