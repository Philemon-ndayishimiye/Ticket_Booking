import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => {context.go('/profile')},
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Privacy & Policy"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Privacy & Policy",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              "Your privacy is important to us. We respect and protect your personal information, including your name, email, and booking details. "
              "All data collected is used solely for improving your ticket booking experience and will never be shared with unauthorized third parties.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 12),
            Text(
              "We use secure systems to store your data, and all online transactions are encrypted to protect your payment information.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 12),
            Text(
              "By using our app, you consent to our data collection and privacy practices. "
              "You have the right to request access or deletion of your personal information at any time.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
