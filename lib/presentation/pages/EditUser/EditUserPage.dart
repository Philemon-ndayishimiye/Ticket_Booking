import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ticket_booking/data/models/complete_profile_model.dart';
import 'package:ticket_booking/injection.dart';
import 'package:ticket_booking/presentation/pages/signup/widget/Custom_Input.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _fullNameController;
  late TextEditingController _phoneController;
  late TextEditingController _birthDateController;
  late TextEditingController _genderController;
  late TextEditingController _countryController;

  bool _loading = true;
  String? _error;
  CompleteProfile? profile;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final result = await SimpleDI.userRepository.getCompleteProfile();
      profile = result;

      _fullNameController = TextEditingController(text: profile!.fullName);
      _phoneController = TextEditingController(text: profile!.phone);
      _birthDateController = TextEditingController(text: profile!.birthDate);
      _genderController = TextEditingController(text: profile!.gender);
      _countryController = TextEditingController(text: profile!.country);

      setState(() => _loading = false);
    } catch (e) {
      setState(() {
        _error = "Failed to load profile: $e";
        _loading = false;
      });
    }
  }

  Future<void> _updateProfile() async {
  if (!_formKey.currentState!.validate()) return;

  setState(() => _loading = true);

  try {
    final updatedProfile = await SimpleDI.userRepository.updateUserProfile(
      fullName: _fullNameController.text,
      gender: _genderController.text,
      phone: _phoneController.text,
      country: _countryController.text,
      birthDate: _birthDateController.text,
    );

    setState(() {
      profile = updatedProfile;
      _loading = false;
    });

    // Show snackbar first
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Profile updated successfully"),
        duration: Duration(milliseconds: 1000),
      ),
    );

    // Give snackbar a moment to show
    await Future.delayed(const Duration(milliseconds: 1000));

    context.go('/myprofile');
  } catch (e, st) {
    setState(() => _loading = false);
    debugPrint('Update profile error: $e\n$st');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Failed to update profile: $e")),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    if (_loading)
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    if (_error != null) return Scaffold(body: Center(child: Text(_error!)));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/profile'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Edit Profile"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomSelectInput(
                labelText: "Full Name",
                hintText: "Enter full name",
                controller: _fullNameController,
                mode: InputMode.text,
              ),
              const SizedBox(height: 16),

              CustomSelectInput(
                labelText: "Phone",
                hintText: "Enter phone",
                controller: _phoneController,
                mode: InputMode.text,
              ),
              const SizedBox(height: 16),

              CustomSelectInput(
                labelText: "Gender",
                hintText: "Select gender",
                controller: _genderController,
                mode: InputMode.gender,
              ),
              const SizedBox(height: 16),

              CustomSelectInput(
                labelText: "Country",
                hintText: "Select country",
                controller: _countryController,
                mode: InputMode.country,
              ),
              const SizedBox(height: 16),

              CustomSelectInput(
                labelText: "Birth Date",
                hintText: "Select birth date",
                controller: _birthDateController,
                mode: InputMode.date,
              ),
              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: _updateProfile,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text("Update Profile"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
