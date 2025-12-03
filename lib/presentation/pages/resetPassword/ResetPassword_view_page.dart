import 'package:flutter/foundation.dart';
import 'package:ticket_booking/data/repositories/user_repository.dart';
import 'package:ticket_booking/core/utils/validators.dart';

class ResetViewModel extends ChangeNotifier {
  final UserRepository _userRepository;

  ResetViewModel(this._userRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> requestOtp(String email) async {
    // Step 1: Validate
    if (!isValidEmail(email)) {
      _errorMessage = "Please enter a valid email address.";
      notifyListeners();
      return false;
    }

    // Step 2: Trigger loading state
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Step 3: Call repository
      await _userRepository.requestOtp(email: email);
      return true;
    } catch (e) {
      // Handle any network/backend errors
      _errorMessage = "Failed to send OTP. Please try again.";
      if (kDebugMode) print("ResetViewModel Error: $e");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
