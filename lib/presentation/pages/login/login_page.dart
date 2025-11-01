import 'package:flutter/material.dart';
import 'package:ticket_booking/presentation/widget/app_text_field.dart';
import 'package:ticket_booking/presentation/widget/app_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool loading = false; // Example loading state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      backgroundColor: const Color.fromARGB(255, 1, 88, 236),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 60),

            // 👤 Centered User Icon
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white24,
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 60,
              ),
            ),

            const SizedBox(height: 40),

            // 📧 Email input
            CustomInputField(
              hintText: 'Email',
              suffixIcon: Icons.email,
              controller: _email,
            ),

            // 🔒 Password input
            CustomInputField(
              hintText: 'Password',
              suffixIcon: Icons.visibility,
              controller: _password,
              obscureText: true,
            ),

            const SizedBox(height: 8),

            // 🔹 Forgot Password text
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  // Navigate to forgot password page
                  print('Forgot password tapped!');
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Login button or loading
            loading
                ? const Center(child: CircularProgressIndicator(color: Colors.blue))
                : AppButton(
                    label: 'Login',
                    onPressed: () async {
                      final email = _email.text.trim();
                      final password = _password.text.trim();

                      if (email.isEmpty || password.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please enter both fields')),
                        );
                        return;
                      }

                      setState(() {
                        loading = true;
                      });

                      // Simulate login delay
                      await Future.delayed(const Duration(seconds: 2));

                      setState(() {
                        loading = false;
                      });

                      // Navigate to home (example)
                      // context.go('/home');
                      print('Login attempted with $email / $password');
                    },
                    backgroundColor: Colors.blue,
                  ),

            const SizedBox(height: 16),

            // 🔹 "Or" separator
            const Center(
              child: Text(
                'or',
                style: TextStyle(color: Colors.white70),
              ),
            ),

            const SizedBox(height: 16),

            // 🔹 Create New Account button
            AppButton(
              label: 'Create New Account',
              onPressed: () {
                print('Navigate to register page');
              },
              backgroundColor: Colors.white, // Make button visible on blue
              textColor: Colors.blue,
              // textColor: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }
}
