import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String hintText;
  final IconData? suffixIcon;
  final TextEditingController? controller;
  final bool obscureText;

  const CustomInputField({
    Key? key,
    required this.hintText,
    this.suffixIcon,
    this.controller,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12), // margin between inputs ~3*4=12px
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1), // x:3*4=12, y:1*4=4
      decoration: BoxDecoration(
        color: Colors.grey[100], // gray-500 background
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.black),
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black),
          border: InputBorder.none, // no border
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          suffixIcon: suffixIcon != null
              ? Icon(suffixIcon, color: Colors.black)
              : null,
          contentPadding: EdgeInsets.zero, // already using container padding
        ),
      ),
    );
  }
}
