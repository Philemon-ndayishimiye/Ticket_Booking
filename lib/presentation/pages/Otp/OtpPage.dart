import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ticket_booking/presentation/widget/app_button.dart';
import 'package:ticket_booking/presentation/pages/Otp/widget/CustomInputOtp.dart';

class OtpPage extends StatefulWidget {
  final String email; //  receive email here
  const OtpPage({Key? key, required this.email}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  late Timer _timer;
  int _remainingSeconds = 300;
  String? _enteredOtp;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds == 0) {
        timer.cancel();
      } else {
        setState(() => _remainingSeconds--);
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime() {
    final minutes = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  void _onOtpCompleted(String otp) {
    setState(() {
      _enteredOtp = otp;
    });
  }

  void _onVerifyPressed() {
    if (_remainingSeconds <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP has expired. Please request a new one.')),
      );
      return;
    }

    if (_enteredOtp == null || _enteredOtp!.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the full OTP')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP Verified!')),
      );

      // ✅ Pass both email and otp together
      context.go('/newpassword', extra: {
        'email': widget.email,
        'otp': _enteredOtp!,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isExpired = _remainingSeconds <= 0;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/login'),
          icon: const Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.blue,
        title: const Text(
          'Enter OTP',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromRGBO(240, 248, 255, 1.0),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blueAccent,
              child: Icon(Icons.lock_clock, color: Colors.white, size: 80),
            ),
            const SizedBox(height: 24),
            const Text(
              'OTP Verification',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              isExpired
                  ? 'OTP expired! Please request again.'
                  : 'Your OTP will expire in ${_formatTime()}',
              style: TextStyle(
                fontSize: 16,
                color: isExpired ? Colors.red : Colors.black54,
              ),
            ),
            const SizedBox(height: 40),
            CustomOtpInput(onCompleted: _onOtpCompleted),
            const SizedBox(height: 50),
            AppButton(
              label: 'Verify OTP',
              onPressed: _onVerifyPressed,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
