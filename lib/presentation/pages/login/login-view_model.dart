import 'package:flutter/foundation.dart';
import 'package:ticket_booking/data/repositories/user_repository.dart';
import 'package:ticket_booking/core/services/storage_service.dart';

class LoginViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  final StorageService storageService;

  bool _loading = false;
  bool get loading => _loading;

  LoginViewModel({
    required this.userRepository,
    required this.storageService,
  });

  Future<bool> login(String username, String password) async {
    _loading = true;
    notifyListeners();

    try {
      final user = await userRepository.login(
        username: username,
        password: password,
      );

      // Token and userId already saved in repository
      _loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      print('Login error: $e');
      _loading = false;
      notifyListeners();
      return false;
    }
  }
}
