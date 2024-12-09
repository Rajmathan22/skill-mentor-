import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillzmentors/Screens/login_signup/sign_up_ui/FileUpload_screen.dart';
import 'package:skillzmentors/Screens/login_signup/sign_up_ui/Password_create.dart';
import 'package:skillzmentors/Screens/login_signup/sign_up_ui/phoneverify_page.dart';
import 'package:skillzmentors/Screens/login_signup/login_ui/Login_Screen.dart';
import 'package:skillzmentors/Screens/login_signup/utils/Dob_widget.dart';
import 'package:skillzmentors/Screens/login_signup/utils/Gender_widegt.dart';
import 'package:skillzmentors/Screens/login_signup/utils/SignUp_entrifieild.dart';
import 'package:skillzmentors/Screens/login_signup/utils/otp_screen.dart';
import 'package:skillzmentors/ViewModel/login_signup_bloc/signup_bloc.dart';
import 'package:skillzmentors/ViewModel/login_signup_bloc/signup_state.dart';
import 'package:skillzmentors/ViewModel/login_signup_bloc/signup_event.dart';
import 'package:skillzmentors/Components/AppBar/default_app_bar.dart';

class Signup_Admin_Page extends StatelessWidget {
  const Signup_Admin_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const DefaultAppBar(
          hideNotifcationIcon: true,
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(
                top: 20.0, // Adjusted to provide spacing from AppBar
                bottom: 10.0,
              ),
              child: Text(
                "Skillz Mentor Admin",
                style: TextStyle(
                  fontFamily: "Times New Roman",
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.blue,
                ),
              ),
            ),
            BlocBuilder<SignupBloc, SignupState>(
              builder: (context, state) {
                int currentStep = _getCurrentStep(state);
                return _buildProgressBar(
                    currentStep); // Progress bar moved below the text
              },
            ),
            Expanded(
              child: BlocBuilder<SignupBloc, SignupState>(
                builder: (context, state) {
                  if (state is PersonalDetailsState) {
                    return _buildPersonalDetailsForm(context);
                  } else if (state is PhoneVerificationState) {
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

  int _getCurrentStep(SignupState state) {
    if (state is PersonalDetailsState) {
      return 0;
    } else if (state is AddressDetailsState) {
      return 1;
    } else {
      return 2; // Completed
    }
  }

  Widget _buildProgressBar(int currentStep) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStepIndicator(Icons.person, currentStep >= 0),
          Expanded(
            child: Divider(
              thickness: 5,
              color: currentStep >= 1 ? Colors.blue : Colors.grey,
            ),
          ),
          _buildStepIndicator(Icons.school_outlined, currentStep >= 1),
          Expanded(
            child: Divider(
              thickness: 2,
              color: currentStep == 2 ? Colors.blue : Colors.grey,
            ),
          ),
          _buildStepIndicator(Icons.verified, currentStep == 2),
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

  Widget _buildPersonalDetailsForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Personal Details",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: "Times New Roman",
              ),
            ),
            const SizedBox(height: 16),
            const entryField(
              title: "First Name",
              iconData: Icons.person,
            ),
            const entryField(
              title: "Last Name",
              iconData: Icons.person_outline,
            ),
            const Text(
              "Gender",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            GenderSelection(
              onGenderSelected: (gender) {
                print("Selected Gender: $gender");
              },
            ),
            const SizedBox(height: 16),
            const Text(
              "Date of Birth",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            DateOfBirthField(
              onDateSelected: (date) {
                print("Selected Date of Birth: $date");
              },
            ),
            const SizedBox(
              height: 12,
            ),
            const entryField(
              title: "Phone Number",
              iconData: Icons.phone,
            ),
            const entryField(
              title: "Email",
              iconData: Icons.email,
            ),
            ElevatedButton(
              onPressed: () {
                context.read<SignupBloc>().add(GoToPhoneVerificationEvent());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size(200, 50),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Next",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Times New Roman",
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildphone(BuildContext context) {
    final TextEditingController phoneController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            context.read<SignupBloc>().add(PreviousEducationEvent());
            // Navigate back to the previous page
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Contact Details",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: "Times New Roman",
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: PhoneNumberVerificationWidget(
        phoneController: phoneController,
        onVerify: () {
          BlocProvider.of<SignupBloc>(context).add(VerifyPhoneEvent( phonenumber: "",));
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
          BlocProvider.of<SignupBloc>(context).add(PasswordCreateEvent());
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
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => IdentityPage()),
      //     );
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
            "Your Account Has Been Successfully Verified",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
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
