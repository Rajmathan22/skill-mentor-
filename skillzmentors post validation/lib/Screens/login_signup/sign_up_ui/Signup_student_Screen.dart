import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillzmentors/Screens/login_signup/login_ui/Login_Screen.dart';
import 'package:skillzmentors/Screens/login_signup/sign_up_ui/FileUpload_screen.dart';
import 'package:skillzmentors/Screens/login_signup/sign_up_ui/Password_create.dart';
import 'package:skillzmentors/Screens/login_signup/sign_up_ui/phoneverify_page.dart';
import 'package:skillzmentors/Screens/login_signup/utils/Dob_widget.dart';
import 'package:skillzmentors/Screens/login_signup/utils/Gender_widegt.dart';
import 'package:skillzmentors/Screens/login_signup/utils/SignUp_entrifieild.dart';
import 'package:skillzmentors/Screens/login_signup/utils/otp_screen.dart';
import 'package:skillzmentors/Screens/splash_screen/splash_screen.dart';
import 'package:skillzmentors/ViewModel/login_signup_bloc/signup_bloc.dart';
import 'package:skillzmentors/ViewModel/login_signup_bloc/signup_state.dart';
import 'package:skillzmentors/ViewModel/login_signup_bloc/signup_event.dart';
import 'package:skillzmentors/Components/AppBar/default_app_bar.dart';

import '../utils/file_upload.dart';

class StudentSignupPage extends StatefulWidget {
  const StudentSignupPage({super.key});

  @override
  State<StudentSignupPage> createState() => _StudentSignupPageState();
}

class _StudentSignupPageState extends State<StudentSignupPage> {
  late SignupBloc _signupBloc;
  String? _selectedCourse;
  String? _selectedCollege;
  String? _selectedDegreeId;
  String? _selectedDepartment;
  List<String> _departments = [];
  List<String> _colleges = [];
  List<String> _degrees = [];
  List<String> _degreesid = [];
  List<String> _collegeIds = [];
  List<String> _departmentid = [];

  @override
  void initState() {
    super.initState();
    _signupBloc = SignupBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _signupBloc,
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
                "College Student",
                style: TextStyle(
                  fontFamily: "Times New Roman",
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.blue,
                ),
              ),
            ),
            BlocBuilder<SignupBloc, SignupState>(
              builder: (context, state) {
                int currentStep = _getCurrentStep(state);
                return _buildProgressBar(currentStep);
              },
            ),
            Expanded(
              child: BlocListener<SignupBloc, SignupState>(
                listener: (context, state) {
                  if (state is DepartmentsFetchedState) {
                    setState(() {
                      _departments = state.departments;
                      _departmentid = state.departmentid;
                      _degreesid = state.departmentid;
                    });
                  } else if (state is CollegeAndDegreeFetchedState) {
                    setState(() {
                      _colleges = state.colleges;
                      _collegeIds = state.collegeIds;
                      _degrees = state.degrees;
                      _degreesid = state.degreesid;
                    });
                  }
                },
                child: BlocBuilder<SignupBloc, SignupState>(
                  builder: (context, state) {
                    if (state is PersonalDetailsState) {
                      return _buildPersonalDetailsForm(context);
                    } else if (state is AddressDetailsState ||
                        state is CollegeAndDegreeFetchedState ||
                        state is DepartmentsFetchedState) {
                      return _buildEducationDetails(context, _colleges,
                          _degrees, _degreesid, _collegeIds, _departmentid);
                    } else if (state is CourseFetchingErrorState) {
                      return const Center(
                        child: Text("Error fetching courses"),
                      );
                    } else if (state is PhoneVerificationState) {
                      return _buildphone(context);
                    } else if (state is OtpVerificationState) {
                      return _buildOtpVerification(context);
                    } else if (state is PasswordCreateState) {
                      return _buildCreatePasswordPage(context);
                    } else if (state is CompletedState) {
                      return _buildCompletionMessage(context, "Hello");
                    } else if (state is LoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is LoginErrorState) {
                      return Center(
                        child: Column(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  "Error in the login $state.message",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'TimesNewRoman',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                            TextButton(
                                onPressed: () {
                                  _signupBloc.add(SignupInitialEvent());
                                },
                                child: Text("Retry"))
                          ],
                        ),
                      );
                    }
                    return const Center(child: Text("Unknown state"));
                  },
                ),
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
      return 2;
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
    TextEditingController _firstNameController = TextEditingController();
    TextEditingController _lastNameController = TextEditingController();
    TextEditingController _dateofbirth = TextEditingController();
    TextEditingController _phoneNumberController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _gender = TextEditingController();

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
            entryField(
              controller: _firstNameController,
              title: "First Name",
              iconData: Icons.person,
            ),
            entryField(
              title: "Last Name",
              controller: _lastNameController,
              iconData: Icons.person_outline,
            ),
            const Text(
              "Gender",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 16,
                fontFamily: "Times New Roman",
              ),
            ),
            const SizedBox(height: 8),
            GenderSelection(
              onGenderSelected: (gender) {
                _gender.text = gender;
              },
            ),
            const SizedBox(height: 16),
            const Text(
              "Date of Birth",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 16,
                fontFamily: "Times New Roman",
              ),
            ),
            const SizedBox(height: 8),
            DateOfBirthField(
              onDateSelected: (date) {
                _dateofbirth.text = date.toString();
              },
            ),
            const SizedBox(
              height: 12,
            ),
            entryField(
              title: "Phone Number",
              iconData: Icons.phone,
              controller: _phoneNumberController,
            ),
            entryField(
              title: "Email",
              iconData: Icons.email,
              controller: _emailController,
            ),
            ElevatedButton(
              onPressed: () {
                if (_firstNameController.text.isEmpty ||
                    _lastNameController.text.isEmpty ||
                    _gender.text.isEmpty ||
                    _dateofbirth.text.isEmpty ||
                    _phoneNumberController.text.isEmpty ||
                    _emailController.text.isEmpty) {
                  const snackBar = SnackBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    behavior: SnackBarBehavior.floating,
                    content: AwesomeSnackbarContent(
                      title: 'Incomplete Form!',
                      message: 'Please fill out all fields before proceeding.',
                      contentType: ContentType.failure,
                    ),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  const snackBar = SnackBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    behavior: SnackBarBehavior.floating,
                    content: AwesomeSnackbarContent(
                      title: 'Loading State!',
                      message: 'Please wait the information is fetching',
                      contentType: ContentType.success,
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  context.read<SignupBloc>().add(FetchCollegeAndDegreeEvent());
                  context.read<SignupBloc>().add(PersonalDeteilsSubmissionEvent(
                        firstName: _firstNameController.text,
                        lastName: _lastNameController.text,
                        gender: _gender.text,
                        dob: _dateofbirth.text,
                        phone: _phoneNumberController.text,
                        email: _emailController.text,
                      ));
                }
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

  Widget _buildEducationDetails(
      BuildContext context,
      List<String> colleges,
      List<String> degrees,
      List<String> degreesid,
      List<String> collegeIds,
      List<String> departmentid) {
    TextEditingController _collegeid = TextEditingController();
    TextEditingController _degreeid = TextEditingController();
    TextEditingController _yearcontroller = TextEditingController();
    TextEditingController _rollnumbercontroller = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Education Details",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: "TimesNewRoman",
              ),
            ),
            const SizedBox(height: 16),
            if (colleges.isNotEmpty && collegeIds.isNotEmpty)
              SizedBox(
                width: double.infinity,
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'College Name',
                    prefixIcon: const Icon(Icons.school),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  items: colleges.asMap().entries.map((entry) {
                    int index = entry.key;
                    String college = entry.value;
                    return DropdownMenuItem<String>(
                      value: collegeIds[index],
                      child: Text(college),
                    );
                  }).toList(),
                  onChanged: (value) {
                    _collegeid.text = value!;

                    setState(() {
                      _selectedCollege = value;
                    });
                  },
                  value: _selectedCollege,
                ),
              ),
            const SizedBox(height: 16),
            if (degrees.isNotEmpty && degreesid.isNotEmpty)
              SizedBox(
                width: double.infinity,
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Degree',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  items: degrees.asMap().entries.map((entry) {
                    int index = entry.key;
                    String degree = entry.value;
                    return DropdownMenuItem<String>(
                      value: degree,
                      child: Text(degree),
                      onTap: () {
                        _selectedDegreeId = degreesid[index];
                      },
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _degreeid.text = value!;
                      print('Selected Degree ID: $_degreeid.text');
                      context.read<SignupBloc>().add(
                          FetchDepartmentEvent(degreeid: _selectedDegreeId!));
                    });
                    const snackBar = SnackBar(
                      elevation: 0,
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.transparent,
                      behavior: SnackBarBehavior.floating,
                      content: AwesomeSnackbarContent(
                        title: 'Loading Branch',
                        message: 'Please wait ......',
                        contentType: ContentType.success,
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  value: _selectedCourse,
                ),
              ),
            const SizedBox(height: 16),
            if (departmentid.isNotEmpty)
              SizedBox(
                width: double.infinity,
                child: Visibility(
                  visible: _departments.isNotEmpty,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Department',
                      prefixIcon: const Icon(Icons.business),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    items: _departments.asMap().entries.map((entry) {
                      int index = entry.key;
                      String department = entry.value;
                      return DropdownMenuItem<String>(
                        value: departmentid[index].toString(),
                        child: Text(department),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedDepartment =
                            value; // Set the selected department ID
                      });
                    },
                    value: _selectedDepartment,
                  ),
                ),
              ),
            entryField(
              title: "Year",
              controller: _yearcontroller,
              iconData: Icons.calendar_month,
            ),
            entryField(
              title: "Roll Number",
              controller: _rollnumbercontroller,
              iconData: Icons.person_outline,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<SignupBloc>().add(PreviousEducationEvent());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      "Back",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_selectedCollege != null &&
                          _selectedDegreeId != null &&
                          _selectedDepartment != null &&
                          _yearcontroller.text.isNotEmpty &&
                          _rollnumbercontroller.text.isNotEmpty) {
                        //info: this is for sending the data
                        context.read<SignupBloc>().add(EducationDetilsEvent(
                              collegeid: _selectedCollege!, // Use college ID
                              departmentid: _selectedDepartment!,
                              rollnumebr: _rollnumbercontroller.text,
                              year: _yearcontroller.text,
                            ));
                        //info: for navigation
                        context
                            .read<SignupBloc>()
                            .add(GoToPhoneVerificationEvent());
                      } else {
                        const snackBar = SnackBar(
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          behavior: SnackBarBehavior.floating,
                          content: AwesomeSnackbarContent(
                            title: 'Form Incomplete!',
                            message:
                                'Please select all required fields and fill out the year and roll number.',
                            contentType: ContentType.failure,
                          ),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text("Next",
                        style: TextStyle(
                            fontFamily: "Times New Roman",
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20)),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
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

            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Contact Details",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: "Times New Roman",
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: PhoneNumberVerificationWidget(
        phoneController: phoneController,
        onVerify: () {
          print("before calling the phone number");
          BlocProvider.of<SignupBloc>(context).add(
            VerifyPhoneEvent(phonenumber: phoneController.text),
          );
        },
      ),
    );
  }

  Widget _buildOtpVerification(BuildContext context) {
    //hack: need to implement the OTP verification for the using the firebase  under implementation

    final TextEditingController otpController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "OTP Verification",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: "Times New Roman",
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: OtpVerify(
        onVerify: () {
          _signupBloc.add(PasswordCreateEvent());
        },
      ),
    );
  }

  Widget _buildCreatePasswordPage(BuildContext context) {
    String? password; // Variable to store the password

    void _onPasswordCreated(String newPassword) async {
      password = newPassword;

      // Call the Bloc with the password
      final signupBloc = BlocProvider.of<SignupBloc>(context);
      signupBloc.add(PasswordEvent(password: password!));
      signupBloc.add(SubmitFormEventFinal());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create Password",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: "Times New Roman",
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: CreatePasswordPage(
        onCreatePassword: _onPasswordCreated, // Pass the callback
      ),
    );
  }

  Widget _buildCompletionMessage(BuildContext context, String name) {
   
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
          Text(
            "Welcome $name !",
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
