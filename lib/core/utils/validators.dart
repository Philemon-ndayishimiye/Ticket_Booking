bool isValidEmail(String email) {
  // Simple email validation
  final regex = RegExp(r'^\S+@\S+\.\S+$');
  return regex.hasMatch(email);
}

bool isNotEmpty(String value) => value.trim().isNotEmpty;
