import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_booking/core/network/api_client.dart';
import 'package:ticket_booking/core/services/storage_service.dart';
import 'package:ticket_booking/data/repositories/user_repository.dart';
import 'package:ticket_booking/presentation/pages/password/passwordViewModel.dart';
import 'package:ticket_booking/presentation/widget/app_button.dart';

class NewPasswordPage extends StatelessWidget {
  final String otpCode;
  final String email; //  Add email

  const NewPasswordPage({Key? key, required this.otpCode, required this.email}) : super(key: key);

  Future<NewPasswordViewModel> _createViewModel() async {
   
    final prefs = await SharedPreferences.getInstance(); //  async call
   // final storageService = StorageService(prefs); //  pass prefs
    final storage = StorageService(prefs);
    final apiClient = ApiClient(storageService: storage);
    final userRepo = UserRepository(apiClient, storage);
    return NewPasswordViewModel(userRepo);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NewPasswordViewModel>(
      future: _createViewModel(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        return ChangeNotifierProvider.value(
          value: snapshot.data!,
          child: _NewPasswordView(
            otpCode: otpCode,
            email: email, // ✅ Pass email to child
          ),
        );
      },
    );
  }
}

class _NewPasswordView extends StatefulWidget {
  final String otpCode;
  final String email; // ✅ Declare email here

  const _NewPasswordView({Key? key, required this.otpCode, required this.email}) : super(key: key);

  @override
  State<_NewPasswordView> createState() => _NewPasswordViewState();
}

class _NewPasswordViewState extends State<_NewPasswordView> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmVisible = false;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _onResetPasswordPressed(BuildContext context) async {
    final newPassword = _newPasswordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    final viewModel = context.read<NewPasswordViewModel>();

    final success = await viewModel.resetPassword(
      otpCode: widget.otpCode,
      email: widget.email, //  Now this works
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );

    if (success) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password reset successfully!')),
        );
        context.go('/success');
      }
    } else {
      if (context.mounted && viewModel.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(viewModel.errorMessage!)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<NewPasswordViewModel>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/login'),
          icon: const Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.blue,
        title: const Text(
          'Set New Password',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromRGBO(240, 248, 255, 1.0),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blueAccent,
              child: Icon(Icons.lock_outline, color: Colors.white, size: 80),
            ),
            const SizedBox(height: 34),
            const Text(
              'Create a New Password',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 44),
            TextField(
              controller: _newPasswordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'New Password',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _confirmPasswordController,
              obscureText: !_isConfirmVisible,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(_isConfirmVisible ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() => _isConfirmVisible = !_isConfirmVisible),
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 44),
            viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : AppButton(
                    label: 'Reset Password',
                    onPressed: () => _onResetPasswordPressed(context),
                    backgroundColor: Colors.blue,
                    textColor: Colors.white,
                  ),
          ],
        ),
      ),
    );
  }
}
