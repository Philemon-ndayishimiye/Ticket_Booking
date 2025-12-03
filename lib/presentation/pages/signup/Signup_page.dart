import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ticket_booking/core/network/api_client.dart';
import 'package:ticket_booking/core/services/storage_service.dart';
import 'package:ticket_booking/presentation/pages/signup/Signup_view_model.dart';
import 'package:ticket_booking/presentation/widget/app_button.dart';
import 'package:ticket_booking/presentation/pages/signup/widget/Custom_Input.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_booking/data/repositories/user_repository.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _your_country = TextEditingController();
  final TextEditingController _full_name = TextEditingController();
  final TextEditingController _birth_date = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password_confirm = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool loading = false; // Example loading state
  SignupViewModel? signupViewModel;
  bool initializing = true;

  @override
  void initState() {
    super.initState();
    _initializeViewSignupmodel();
  }

  Future<void> _initializeViewSignupmodel() async {
    final prefs = await SharedPreferences.getInstance(); //  async call
    final storageService = StorageService(prefs); //  pass prefs
    final storage = StorageService(prefs);
    final apiClient = ApiClient(storageService: storage);

    setState(() {
      signupViewModel = SignupViewModel(
        userRepository: UserRepository(apiClient, storageService),
      );
      initializing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => {context.go('/login')},
          icon: const Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.blue,
        title: Text('Create Your Account'),
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
            const SizedBox(height: 4),

            // Centered User Icon
            Text(
              'Create an Account ?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            const SizedBox(height: 8),

            //  full name input
            CustomSelectInput(
              hintText: 'Full Names',
              labelText: 'full Name',
              controller: _full_name,
            ),

            const SizedBox(height: 10),
            CustomSelectInput(
              hintText: 'male',
              labelText: 'gender',
              mode: InputMode.gender,
              controller: _gender,
            ),

            // country
            const SizedBox(height: 10),
            CustomSelectInput(
              hintText: 'Rwanda',
              labelText: 'Your Country',
              mode: InputMode.country,
              controller: _your_country,
            ),

            // date of birth
            const SizedBox(height: 10),
            CustomSelectInput(
              hintText: 'yy/mm/dd',
              labelText: 'date of birth',
              mode: InputMode.date,
              controller: _birth_date,
            ),

            //email input
            const SizedBox(height: 10),
            CustomSelectInput(
              hintText: 'example@yahoo.com',
              labelText: 'Email',
              mode: InputMode.email,
              controller: _email,
            ),

            // phone number input
            const SizedBox(height: 10),
            CustomSelectInput(
              hintText: '0724567890',
              labelText: 'Phone Number',
              controller: _phone,
            ),

            // phone number input
            const SizedBox(height: 10),
            CustomSelectInput(
              hintText: 'password',
              labelText: 'Password',
              mode: InputMode.password,
              controller: _password,
            ),

            // phone number input
            const SizedBox(height: 10),
            CustomSelectInput(
              hintText: 'confirmPassword',
              labelText: 'Confirm Password',
              mode: InputMode.password,
              controller: _password_confirm,
            ),

            const SizedBox(height: 16),
            // 🔹 Login button or loading
            loading
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.blue),
                  )
                : const SizedBox(height: 16),
            AppButton(
              label: 'Sign Up',
              onPressed: () async {
                final email = _email.text.trim();
                final phone = _phone.text.trim();
                final password = _password.text.trim();
                final password_confirm = _password_confirm.text.trim();
                final your_country = _your_country.text.trim();
                final gender = _gender.text.trim();
                final full_name = _full_name.text.trim();
                final birth_date = _birth_date.text.trim();

                if (email.isEmpty ||
                    password.isEmpty ||
                    phone.isEmpty ||
                    password_confirm.isEmpty ||
                    your_country.isEmpty ||
                    gender.isEmpty ||
                    full_name.isEmpty ||
                    birth_date.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill all fields')),
                  );
                  return;
                }
                setState(() {
                  loading = true;
                });

                if (signupViewModel == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please wait, initializing...'),
                    ),
                  );
                  return;
                }
                try {
                  final success = await signupViewModel!.register(
                    email,
                    password,
                    password_confirm,
                    phone,
                    your_country,
                    gender,
                    full_name,
                    birth_date,
                  );

                  setState(() => loading = false);

                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Registration successful')),
                    );
                    context.go('/login');
                  }
                } catch (e) {
                  setState(() => loading = false);

                  // Show backend error clearly
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Registration failed')),
                  );
                }
              },
              backgroundColor: Colors.blueAccent, // Make button visible on blue
              textColor: Colors.white,
              // textColor: Colors.blueAccent,
            ),

            const SizedBox(height: 5),
            Text(
              'Or',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            // 🔹 Create New Account button
            AppButton(
              label: 'Back to login ',
              onPressed: () {
                context.go('/login');
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
