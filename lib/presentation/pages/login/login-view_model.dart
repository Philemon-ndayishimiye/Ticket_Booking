import 'package:flutter/foundation.dart';
import 'package:ticket_booking/data/repositories/user_repository.dart';
import 'package:ticket_booking/core/services/storage_service.dart';

class LoginViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  final StorageService storageService;

  bool _loading = false;
  bool get loading => _loading;

  LoginViewModel({required this.userRepository, required this.storageService});

  Future<bool> login(String email, String password) async {
    _loading = true;
    notifyListeners();

    try {
      final response = await userRepository.login(
        email: email,
        password: password,
      );

      // Check the status from API response
      if (response.status == 'success') {
        // Save tokens and userId
        if (response.access != null) {
          await storageService.saveToken(response.access!);
        }
        if (response.user?.id != null) {
          await storageService.saveUserId(response.user!.id!);
        }
        _loading = false;
        notifyListeners();
        return true;
      } else {
        _loading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print('Login error: $e');
      _loading = false;
      notifyListeners();
      return false;
    }
  }
}
