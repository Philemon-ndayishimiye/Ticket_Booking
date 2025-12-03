import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ticket_booking/presentation/widget/app_button.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 248, 255, 1.0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ✅ Success Icon
                const CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.blueAccent,
                  child: Icon(
                    Icons.check_circle_outline,
                    color: Colors.white,
                    size: 80,
                  ),
                ),

                const SizedBox(height: 40),

                // ✅ Success Title
                const Text(
                  'Password Reset Successful!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 16),

                // ✅ Subtitle / Message
                const Text(
                  'Your password has been updated successfully.\nYou can now log in with your new password.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 50),

                // ✅ Go to Login Button
                AppButton(
                  label: 'Back to Login',
                  onPressed: () => context.go('/login'),
                  backgroundColor: Colors.blue,
                  textColor: Colors.white,
                ),

                const SizedBox(height: 20),

                // ✅ Optional subtle animation or icon fade
                AnimatedOpacity(
                  opacity: 1.0,
                  duration: const Duration(seconds: 2),
                  child: const Icon(
                    Icons.lock_reset,
                    size: 40,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
