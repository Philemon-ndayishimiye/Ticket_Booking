import 'package:flutter/foundation.dart';
import 'package:ticket_booking/data/repositories/user_repository.dart';

class SignupViewModel extends ChangeNotifier {
  final UserRepository userRepository;

  bool _loading = false;
  bool get loading => _loading;

  SignupViewModel({required this.userRepository});

  Future<bool> register(
    String email,
    String password,
    String password_confirm,
    String phone,
    String your_country,
    String gender,
    String full_name,
    String birth_date,
  ) async {
    _loading = true;
    notifyListeners();

    try {
      await userRepository.createUser(
        email: email,
        password: password,
        full_name: full_name,
        phone: phone,
        password_confirm: password_confirm,
        your_country: your_country,
        gender: gender,
        birth_date: birth_date,
      );

      // Token and userId already saved in repository
      _loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      print('Login Register error : $e');
      _loading = false;
      notifyListeners();
      return false;
    }
  }
}
