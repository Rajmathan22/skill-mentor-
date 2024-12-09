import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillzmentors/Components/AppBar/default_app_bar.dart';
import 'package:skillzmentors/Screens/login_signup/sign_up_ui/Password_create.dart';
import 'package:skillzmentors/Screens/login_signup/sign_up_ui/phoneverify_page.dart';
import 'package:skillzmentors/Screens/login_signup/login_ui/Login_Screen.dart';
import 'package:skillzmentors/Screens/login_signup/utils/otp_screen.dart';
import 'package:skillzmentors/ViewModel/login_signup_bloc/forget_bloc.dart';
import 'package:skillzmentors/ViewModel/login_signup_bloc/forget_event.dart';
import 'package:skillzmentors/ViewModel/login_signup_bloc/forget_state.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const DefaultAppBar(
          hideNotifcationIcon: true,
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(
                top: 20.0,
                bottom: 10.0,
              ),
              child: Text(
                "Reset Password",
                style: TextStyle(
                  fontFamily: "Times New Roman",
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.blue,
                ),
              ),
            ),
            BlocBuilder<ForgetBloc, ForgetState>(
              builder: (context, state) {
                int currentStep = _getCurrentStep(state);
                return _buildProgressBar(currentStep);
              },
            ),
            Expanded(
              child: BlocBuilder<ForgetBloc, ForgetState>(
                builder: (context, state) {
                  if (state is PhoneVerificationState) {
                    return _buildphone(context);
                  } else if (state is OtpVerificationState) {
                    return _buildOtpVerification(context);
                  } else if (state is PasswordCreateState) {
                    return _buildCreatePasswordPage(context);
                  } else if (state is CompletedState) {
                    return _buildCompletionMessage(context);
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _getCurrentStep(ForgetState state) {
    if (state is PhoneVerificationState) {
      return 0;
    } else if (state is OtpVerificationState) {
      return 1;
    } else if (state is PasswordCreateState) {
      return 2;
    } else {
      return 3; // Completed
    }
  }

  Widget _buildProgressBar(int currentStep) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStepIndicator(Icons.phone, currentStep >= 0),
          Expanded(
            child: Divider(
              thickness: 2,
              color: currentStep >= 1 ? Colors.blue : Colors.grey,
            ),
          ),
          _buildStepIndicator(Icons.sms, currentStep >= 1),
          Expanded(
            child: Divider(
              thickness: 2,
              color: currentStep >= 2 ? Colors.blue : Colors.grey,
            ),
          ),
          _buildStepIndicator(Icons.lock, currentStep >= 2),
          Expanded(
            child: Divider(
              thickness: 2,
              color: currentStep == 3 ? Colors.blue : Colors.grey,
            ),
          ),
          _buildStepIndicator(Icons.verified, currentStep == 3),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(IconData icon, bool isActive) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: isActive ? Colors.blue : Colors.grey,
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }

  Widget _buildphone(BuildContext context) {
    final TextEditingController phoneController = TextEditingController();

    return Scaffold(
      body: PhoneNumberVerificationWidget(
        phoneController: phoneController,
        onVerify: () {
          BlocProvider.of<ForgetBloc>(context).add(VerifyPhoneEvent());
        },
      ),
    );
  }

  Widget _buildOtpVerification(BuildContext context) {
    final TextEditingController otpController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "OTP Verification",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: "Times New Roman",
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: OtpVerify(
        onVerify: () {
          // Handle OTP verification here
          // For example, dispatch event to BLoC to verify OTP
          BlocProvider.of<ForgetBloc>(context).add(CreatePasswordEvent());
        },
      ),
    );
  }

  Widget _buildCreatePasswordPage(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create Password",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: "Times New Roman",
          ),
        ),
        backgroundColor: Colors.white,
      ),
      // body: CreatePasswordPage(
      //   onCreatePassword: () {
      //     // Handle password creation here
      //     // For example, dispatch event to BLoC to create password
      //     if (passwordController.text == confirmPasswordController.text) {
      //       BlocProvider.of<ForgetBloc>(context).add(CompletedEvent());
      //     } else {
      //       // Show error if passwords do not match
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         const SnackBar(content: Text("Passwords do not match")),
      //       );
      //     }
      //   },
      // ),
    );
  }

  Widget _buildCompletionMessage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.verified,
            size: 100,
            color: Colors.blue,
          ),
          const SizedBox(height: 20),
          const Text(
            "Welcome John",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const Text(
            "Your Password Has Been Successfully Changed",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              fontFamily: "Times New Roman",
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              minimumSize: const Size(200, 50),
            ),
            child: const Text(
              "Continue",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
