import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final String hintText;
  final String labelText;
  final TextEditingController? controller;
  final bool obscureText;
  final IconData? suffixIcon; //  added back

  const CustomInputField({
    Key? key,
    required this.hintText,
    required this.labelText,
    this.controller,
    this.obscureText = false, // true for password fields
    this.suffixIcon, // optional icon
  }) : super(key: key);

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Determine which suffix icon to show
    Widget? suffix;
    if (widget.obscureText) {
      // Password field: show toggle eye
      suffix = IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: Colors.black,
        ),
        onPressed: _togglePasswordVisibility,
      );
    } else if (widget.suffixIcon != null) {
      // Non-password field: show provided icon
      suffix = Icon(widget.suffixIcon, color: Colors.black);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 0),

        Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextField(
            controller: widget.controller,
            obscureText: _obscureText,
            style: const TextStyle(color: Colors.black, fontSize: 17),
            cursorColor: Colors.black,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: const TextStyle(color: Colors.black, fontSize: 17),
              contentPadding: const EdgeInsets.only(left: 18, top: 9, bottom: 9),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              suffixIcon: suffix,
            ),
          ),
        ),
      ],
    );
  }
}
