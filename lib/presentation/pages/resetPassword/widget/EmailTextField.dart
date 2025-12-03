import 'package:flutter/material.dart';

class CustomInputFieldEmail extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;

  const CustomInputFieldEmail({
    Key? key,
    required this.controller,
    this.hintText = '',
    required this.labelText,
  }) : super(key: key);

  @override
  State<CustomInputFieldEmail> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputFieldEmail> {
  String? _errorText;

  bool _isValidEmail(String email) {
    // Simple but reliable email validation pattern
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  void _validate(String value) {
    setState(() {
      if (value.isEmpty) {
        _errorText = 'Email is required';
      } else if (!_isValidEmail(value)) {
        _errorText = 'Enter a valid email address';
      } else {
        _errorText = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: TextInputType.emailAddress,
      onChanged: _validate,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText.isNotEmpty
            ? widget.hintText
            : 'example@email.com',
        errorText: _errorText,
        prefixIcon: const Icon(Icons.email_outlined),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      style: const TextStyle(fontSize: 16),
    );
  }
}
