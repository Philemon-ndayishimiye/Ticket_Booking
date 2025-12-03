import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ticket_booking/data/models/complete_profile_model.dart';
import 'package:ticket_booking/injection.dart';

class CompleteProfilePage extends StatefulWidget {
  const CompleteProfilePage({Key? key}) : super(key: key);

  @override
  State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  CompleteProfile? profile;
  bool loading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final result = await SimpleDI.userRepository.getCompleteProfile();
      setState(() {
        profile = result;
        loading = false;
      });
    } catch (e) {
      setState(() {
        error = "Failed to load profile";
        loading = false;
      });
    }
  }

  // 🔹 Navigate to edit page
  void _navigateToEdit() {
    context.go('/editprofile');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/profile'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          profile?.fullName ?? "Profile",
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          // Single edit icon at top right
          IconButton(icon: const Icon(Icons.edit), onPressed: _navigateToEdit),
        ],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : error != null
          ? Center(child: Text(error!))
          : _buildProfileContent(),
    );
  }

  Widget _buildProfileContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),

          // 🔵 Circular Profile Avatar
          CircleAvatar(
            radius: 55,
            backgroundColor: Colors.blue.shade100,
            child: Icon(Icons.person, size: 70, color: Colors.blue.shade700),
          ),

          const SizedBox(height: 15),

          Text(
            profile!.fullName ?? "Unknown User",
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 5),
          Text(
            profile!.email,
            style: const TextStyle(color: Colors.grey, fontSize: 15),
          ),

          const SizedBox(height: 25),

          // 🔵 Information Section (no individual edit icons)
          _infoTile(Icons.phone, "Phone", profile!.phone),
          _infoTile(Icons.location_on, "Country", profile!.country),
          _infoTile(Icons.person, "Gender", profile!.gender),
          _infoTile(Icons.calendar_month, "Birth Date", profile!.birthDate),
          _infoTile(Icons.web, "Website", profile!.profile?.website),
          _infoTile(Icons.info, "Bio", profile!.profile?.bio),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _infoTile(IconData icon, String title, String? value) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(
        value ?? "Not provided",
        style: const TextStyle(color: Colors.grey),
      ),
    );
  }
}
