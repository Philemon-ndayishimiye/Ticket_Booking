import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_booking/core/network/api_client.dart';
import 'package:ticket_booking/presentation/widget/app_text_field.dart';
import 'package:ticket_booking/presentation/widget/app_button.dart';
import 'package:ticket_booking/presentation/pages/login/login-view_model.dart';
import 'package:ticket_booking/data/repositories/user_repository.dart';
import 'package:ticket_booking/core/services/storage_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginViewModel loginViewModel;

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool loading = false; // Example loading state

  @override
  void initState() {
    super.initState();
    _initializeViewModel();
  }

  Future<void> _initializeViewModel() async {
    final prefs = await SharedPreferences.getInstance(); //  async call
    final storageService = StorageService(prefs);
    // final storageService = StorageService(prefs); //  pass prefs
    final storage = StorageService(prefs);
    final apiClient = ApiClient(storageService: storage);

    setState(() {
      loginViewModel = LoginViewModel(
        userRepository: UserRepository(apiClient, storageService),
        storageService: storageService,
      );
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => {context.go('/')},
          icon: const Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.blue,
        title: Text('ticketLIB'),
        titleTextStyle: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          fontFamily: 'PlayfairDisplay',
        ),
        centerTitle: true,
      ),

      backgroundColor: const Color.fromRGBO(240, 248, 255, 1.0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),

            // 👤 Centered User Icon
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blueAccent,
              child: Icon(Icons.person, color: Colors.white, size: 60),
            ),

            const SizedBox(height: 20),

            const Text(
              'Welcome to ',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 4),

            const Text(
              'ticketLIB Login now!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            //  Email input
            CustomInputField(
              labelText: 'Email',
              hintText: 'example@gmail.com',
              suffixIcon: Icons.email,
              controller: _email,
            ),
            const SizedBox(height: 20),
            //  Password input
            CustomInputField(
              labelText: 'Password',
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
                  context.go('/reset');
                  print('Forgot password tapped!');
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Login button or loading
            loading
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.blue),
                  )
                : AppButton(
                    label: 'Login',
                    onPressed: () async {
                      final email = _email.text.trim();
                      final password = _password.text.trim();

                      if (email.isEmpty || password.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter both fields'),
                          ),
                        );
                        return;
                      }
                      setState(() {
                        loading = true;
                      });

                      final success = await loginViewModel.login(
                        email,
                        password,
                      );

                      setState(() {
                        loading = false;
                      });
                      if (success) {
                        context.go('/'); // or your home route
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('incorrect email or password'),
                          ),
                        );
                      }
                      // Simulate login delay
                      // await Future.delayed(const Duration(seconds: 2));
                      // print('Login attempted with $email / $password');
                    },
                    backgroundColor: Colors.blue,
                  ),

            const SizedBox(height: 16),

            //  "Or" separator
            const Center(
              child: Text(
                'or',
                style: TextStyle(color: Colors.blue, fontSize: 19),
              ),
            ),

            const SizedBox(height: 16),

            // 🔹 Create New Account button
            AppButton(
              label: 'Create New Account',
              onPressed: () {
                context.go('/signup');
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
