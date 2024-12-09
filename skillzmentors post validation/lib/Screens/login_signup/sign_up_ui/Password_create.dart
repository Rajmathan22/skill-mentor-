import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart'; // Import the package
import 'package:skillzmentors/Screens/login_signup/utils/SignUp_entrifieild.dart';
import 'package:skillzmentors/ViewModel/login_signup_bloc/signup_bloc.dart';
import 'package:skillzmentors/ViewModel/login_signup_bloc/signup_event.dart';

class CreatePasswordPage extends StatelessWidget {
  final ValueChanged<String> onCreatePassword; // Change to ValueChanged<String>

  CreatePasswordPage({
    super.key,
    required this.onCreatePassword,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _confirmPasswordController = TextEditingController();

    void _validateAndCreatePassword() {
      if (_passwordController.text == _confirmPasswordController.text) {
        // Pass the password back to the parent
        onCreatePassword(_passwordController.text);
      } else {
        // Show snackbar for error
        final snackBar = const SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: AwesomeSnackbarContent(
            title: 'Error!',
            message: 'Passwords do not match. Please try again.',
            contentType: ContentType.failure,
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.lock,
                size: 100,
                color: Colors.blue,
              ),
              const SizedBox(height: 20),
              const Text(
                "Create a New Password",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 16),
              entryField(
                title: "Password",
                controller: _passwordController,
                iconData: Icons.lock,
              ),
              const SizedBox(height: 20),
              entryField(
                title: "Confirm Password",
                controller: _confirmPasswordController,
                iconData: Icons.lock,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _validateAndCreatePassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  "Create Password",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
