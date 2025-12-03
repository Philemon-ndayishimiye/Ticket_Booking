import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_booking/data/repositories/user_repository.dart';
import 'package:ticket_booking/core/network/api_client.dart';

import 'package:ticket_booking/core/services/storage_service.dart';
import 'package:ticket_booking/presentation/pages/home/widgets/ButtonNavigation.dart'; // your bottom nav

import 'package:ticket_booking/presentation/pages/profile/widget/accountCard.dart';
import 'package:ticket_booking/presentation/pages/profile/widget/notification.dart';
import 'package:ticket_booking/presentation/pages/profile/widget/profileCard.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 4;
  String _username = "John Doe"; // non-nullable
  bool _notificationsEnabled = true;

  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  // load profile
  Future<void> _loadProfile() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final storage = StorageService(prefs);
      final api = ApiClient(storageService: storage);
      final userRepo = UserRepository(api, storage);

      // Read user id using your StorageService method:
      final storedId = storage.readUserId(); // ✅ FIXED HERE

      if (storedId == null) {
        setState(() {
          _error = 'No user id found. Please login.';
          _loading = false;
        });
        return;
      }

      final user = await userRepo.singleUser(id: storedId);

      setState(() {
        _username = user.full_name ?? user.email ?? 'Unknown User';
        _loading = false;
      });
    } catch (e, st) {
      print('Error loading profile: $e\n$st');
      setState(() {
        _error = 'Failed to load profile';
        _loading = false;
      });
    }
  }

  // ... rest of your code (navigation, _showEditDialog, etc.) ...

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      // TODO: handle navigation if needed
    });

    switch (index) {
      case 0:
        // Navigate to Home
        context.go('/');
        print('home');
        break;
      case 1:
        print('discover');
        context.go('/discover');
        break;
      case 2:
        // Navigate to My Tickets
        context.go('/ticketpage');
        print('my ticket');
        break;
      case 3:
        // Navigate to Events
        context.go('/profile');
        print('events');
        break;
      case 4:
        // Navigate to Profile
        context.go('/profile');
        print('profile ');
        break;
    }
  }

  void _updateUsername(String newName) {
    setState(() {
      _username = newName;
    });
  }

  void _toggleNotifications(bool value) {
    setState(() {
      _notificationsEnabled = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 13),
            Container(
              padding: EdgeInsets.fromLTRB(20, 3, 10, 5),
              child: Text(
                'Profile',
                style: TextStyle(
                  fontSize: 21,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // User Info Card
            ProfileInfoCard(
              title: '',
              label: _loading
                  ? 'Loading...'
                  : (_error != null ? 'Please Login ' : _username),
              icon: Icons.person,
              onTap: () => {context.go('/myprofile')},
            ),

            const SizedBox(height: 10),

            Container(
              padding: EdgeInsets.fromLTRB(20, 3, 10, 5),
              child: Text(
                'Display',
                style: TextStyle(
                  fontSize: 21,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            ProfileInfoCard(
              title: '',
              label: 'Theme',
              icon: Icons.arrow_forward_ios,
              onTap: () async {
                // Example: edit username
                // String? newName = await _showEditDialog(context, _username);
                // if (newName != null && newName.isNotEmpty) {
                //   _updateUsername(newName);
                // }
              },
            ),

            const SizedBox(height: 12),

            Container(
              padding: EdgeInsets.fromLTRB(20, 3, 10, 5),
              child: Text(
                'Notifiction',
                style: TextStyle(
                  fontSize: 21,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            //  Setting Card with toggle
            ProfileSettingCard(
              title: 'Account Notifications',
              icon: Icons.notifications,
              initialValue: _notificationsEnabled,
              onChanged: _toggleNotifications,
            ),

            const SizedBox(height: 16),

            Container(
              padding: EdgeInsets.fromLTRB(20, 3, 10, 5),
              child: Text(
                'Accounts',
                style: TextStyle(
                  fontSize: 21,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            //  Flat Card
            const SizedBox(height: 10),
            ProfileFlatCard(
              title: 'Help & Support',
              leftIcon: Icons.help_outline,
              rightIcon: Icons.arrow_forward_ios,
              onTap: () {
                print('Help clicked');
                // Navigate or show dialog
              },
            ),

            // Diactivate account
            const SizedBox(height: 10),
            ProfileFlatCard(
              title: 'Diactivate account',
              leftIcon: Icons.help_outline,
              rightIcon: Icons.arrow_forward_ios,
              onTap: () {
                print('diactivate account');
                // Navigate or show dialog
              },
            ),

            // delete an account
            const SizedBox(height: 10),
            ProfileFlatCard(
              title: 'Delete account',
              leftIcon: Icons.help_outline,
              rightIcon: Icons.arrow_forward_ios,
              onTap: () {
                print('Help clicked');
                // Navigate or show dialog
              },
            ),

            //  Change Password
            const SizedBox(height: 10),
            ProfileFlatCard(
              title: 'change password',
              leftIcon: Icons.help_outline,
              rightIcon: Icons.arrow_forward_ios,
              onTap: () {
                print('change password');
                // Navigate or show dialog
              },
            ),

            const SizedBox(height: 16),

            ProfileFlatCard(
              title: 'Privacy Policy',
              leftIcon: Icons.lock_outline,
              rightIcon: Icons.arrow_forward_ios,
              onTap: () {
                context.go('/privacy');
              },
            ),

            const SizedBox(height: 16),
            ProfileFlatCard(
              title: 'FAQs',
              leftIcon: Icons.lock_outline,
              rightIcon: Icons.arrow_forward_ios,
              onTap: () {
                context.go('/faq');
              },
            ),

            const SizedBox(height: 16),
            ProfileFlatCard(
              title: 'Terms & Conditions',
              leftIcon: Icons.lock_outline,
              rightIcon: Icons.arrow_forward_ios,
              onTap: () {
                context.go('/terms');
              },
            ),

            const SizedBox(height: 16),
            ProfileFlatCard(
              title: 'Report Problem',
              leftIcon: Icons.lock_outline,
              rightIcon: Icons.arrow_forward_ios,
              onTap: () {
                print('Privacy Policy clicked');
              },
            ),

            const SizedBox(height: 16),
            ProfileFlatCard(
              title: 'Sign Out',
              leftIcon: Icons.lock_outline,
              rightIcon: Icons.arrow_forward_ios,
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                final storageService = StorageService(prefs);

                // Create ApiClient with required storageService
                final api = ApiClient(storageService: storageService); //  FIXED

                // Create UserRepository
                final userRepo = UserRepository(api, storageService);

                // Call logout
                await userRepo.logout();

                // Navigate to login page
                if (mounted) {
                  context.go('/login');
                }
              },
            ),
          ],
        ),
      ),

      // Custom bottom navigation bar
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  // Dialog to edit username
  Future<String?> _showEditDialog(
    BuildContext context,
    String currentName,
  ) async {
    TextEditingController controller = TextEditingController(text: currentName);

    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Username'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Enter new username'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, null),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, controller.text),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
