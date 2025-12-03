import 'package:flutter/foundation.dart';
import 'package:ticket_booking/data/repositories/user_repository.dart';

class NewPasswordViewModel extends ChangeNotifier {
  final UserRepository _userRepository;

  NewPasswordViewModel(this._userRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> resetPassword({
    required String otpCode,
    required String email,
    required String newPassword,
    required String confirmPassword,
  }) async {
    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      _errorMessage = "Please fill in all fields";
      notifyListeners();
      return false;
    }

    if (newPassword != confirmPassword) {
      _errorMessage = "Passwords do not match";
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _userRepository.resetpassword(
        otp_code: otpCode,
        email: email,
        new_password: newPassword,
        confirm_password: confirmPassword,
      );
      return true;
    } catch (e) {
      if (kDebugMode) print("Reset password error: $e");
      _errorMessage = "Failed to reset password. Please try again.";
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
