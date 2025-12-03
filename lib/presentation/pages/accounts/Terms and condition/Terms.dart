import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({Key? key}) : super(key: key);

  final String termsContent = '''
Welcome to our Ticket Booking App. By using our services, you agree to the following terms and conditions:

1. **Acceptance of Terms**
By accessing or using our platform, you agree to comply with these terms. If you do not agree, please do not use our services.

2. **User Accounts**
You must provide accurate information when creating an account. You are responsible for all activities under your account.

3. **Ticket Purchase**
All ticket purchases are subject to availability. Prices may change without prior notice. Confirm your tickets before finalizing payment.

4. **Refunds and Cancellations**
Refunds are subject to our refund policy. Cancellations may incur fees as stated during the booking process.

5. **User Conduct**
You agree not to misuse our platform, including but not limited to fraudulent activity, unauthorized access, or disturbing other users’ experience.

6. **Limitation of Liability**
We are not responsible for any indirect, incidental, or consequential losses arising from the use of our services.

7. **Privacy**
Your personal information is handled according to our Privacy Policy.

8. **Changes to Terms**
We may update these terms at any time. Continued use of the platform constitutes acceptance of the new terms.

For questions regarding our terms, contact our support team via the Help & Support page.
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/profile'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Terms & Conditions"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            termsContent,
            style: const TextStyle(fontSize: 16, height: 1.5),
          ),
        ),
      ),
    );
  }
}
