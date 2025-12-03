import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_booking/presentation/widget/app_button.dart';
import 'package:ticket_booking/presentation/pages/resetPassword/widget/EmailTextField.dart';
import 'package:ticket_booking/presentation/pages/resetPassword/ResetPassword_view_page.dart';
import 'package:ticket_booking/data/repositories/user_repository.dart';
import 'package:ticket_booking/core/services/storage_service.dart';
import 'package:ticket_booking/core/network/api_client.dart';

class ResetPage extends StatelessWidget {
  const ResetPage({Key? key}) : super(key: key);

  Future<ResetViewModel> _createViewModel() async {
    final prefs = await SharedPreferences.getInstance(); //  async call
   // final storageService = StorageService(prefs); //  pass prefs
    final storage = StorageService(prefs);
    final apiClient = ApiClient(storageService: storage);
    final userRepo = UserRepository(apiClient, storage);
    return ResetViewModel(userRepo);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ResetViewModel>(
      future: _createViewModel(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return ChangeNotifierProvider.value(
          value: snapshot.data!,
          child: const _ResetView(),
        );
      },
    );
  }
}

class _ResetView extends StatefulWidget {
  const _ResetView();

  @override
  State<_ResetView> createState() => _ResetViewState();
}

class _ResetViewState extends State<_ResetView> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _onSendOtpPressed(BuildContext context) async {
    final viewModel = context.read<ResetViewModel>();
    final email = _emailController.text.trim();

    final success = await viewModel.requestOtp(email);
    if (success) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("OTP sent to $email")));
        context.go('/otp', extra: email);
      }
    } else {
      if (context.mounted && viewModel.errorMessage != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(viewModel.errorMessage!)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ResetViewModel>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/login'),
          icon: const Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.blue,
        title: const Text(
          'Reset Password',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromRGBO(240, 248, 255, 1.0),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blueAccent,
              child: Icon(Icons.lock_reset, color: Colors.white, size: 90),
            ),
            const SizedBox(height: 34),
            const Text(
              'Reset Your Password',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 34),
            CustomInputFieldEmail(
              controller: _emailController,
              hintText: 'example@gmail.com',
              labelText: 'Email Address',
            ),
            const SizedBox(height: 44),
            viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : AppButton(
                    label: 'Send OTP',
                    onPressed: () => _onSendOtpPressed(context),
                    backgroundColor: Colors.blue,
                    textColor: Colors.white,
                  ),
          ],
        ),
      ),
    );
  }
}
