import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:country_picker/country_picker.dart';

enum InputMode { text, email, password, date, gender, country }

class CustomSelectInput extends StatefulWidget {
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final InputMode mode;

  const CustomSelectInput({
    Key? key,
    required this.labelText,
    required this.hintText,
    this.controller,
    this.mode = InputMode.text,
  }) : super(key: key);

  @override
  _CustomSelectInputState createState() => _CustomSelectInputState();
}

class _CustomSelectInputState extends State<CustomSelectInput> {
  bool _obscurePassword = true;
  String? _selectedGender;
  DateTime? _selectedDate;

  final _genderOptions = ['male', 'female'];

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        widget.controller?.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;

    switch (widget.mode) {
      case InputMode.gender:
        child = DropdownButtonFormField<String>(
          value: _selectedGender,
          items: _genderOptions
              .map(
                (gender) =>
                    DropdownMenuItem(value: gender, child: Text(gender)),
              )
              .toList(),
          onChanged: (value) {
            setState(() {
              _selectedGender = value;
              widget.controller?.text = value ?? '';
            });
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hintText,
            hintStyle: TextStyle(fontWeight: FontWeight.bold),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        );
        break;

      case InputMode.date:
        child = GestureDetector(
          onTap: _pickDate,
          child: AbsorbPointer(
            child: TextField(
              controller: widget.controller,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(fontWeight: FontWeight.bold),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                suffixIcon: const Icon(
                  Icons.calendar_today,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        );
        break;

      case InputMode.country:
        child = GestureDetector(
          onTap: () {
            showCountryPicker(
              context: context,
              showPhoneCode: false, // optional: hide phone code
              onSelect: (Country country) {
                setState(() {
                  widget.controller?.text = country.countryCode; // e.g., US, RW
                });
              },
            );
          },
          child: AbsorbPointer(
            child: TextField(
              controller: widget.controller,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(fontWeight: FontWeight.bold),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                suffixIcon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        );
        break;

      case InputMode.password:
        child = TextField(
          controller: widget.controller,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(fontWeight: FontWeight.bold),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.black,
              ),
              onPressed: _togglePasswordVisibility,
            ),
          ),
        );
        break;

      case InputMode.email:
        child = TextField(
          controller: widget.controller,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(fontWeight: FontWeight.bold),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            suffixIcon: const Icon(Icons.email, color: Colors.black),
          ),
        );
        break;

      case InputMode.text:
      default:
        child = TextField(
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(fontWeight: FontWeight.bold),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        );
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade300, width: 1),
          ),
          child: child,
        ),
      ],
    );
  }
}
