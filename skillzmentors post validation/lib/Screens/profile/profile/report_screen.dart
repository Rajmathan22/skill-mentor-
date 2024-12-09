import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillzmentors/Components/AppBar/app_bar_withbackbutton.dart';
import 'package:skillzmentors/Models/proflie_model/report_model.dart';
import 'package:skillzmentors/ViewModel/Profilebloc/report_bloc.dart';
import 'package:skillzmentors/ViewModel/Profilebloc/report_event.dart';
import 'package:skillzmentors/ViewModel/Profilebloc/report_state.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserReportBloc(),
      child: Scaffold(
        appBar: const AppBarWithBackButton(),
        body: Stack(
          children: [
            // Background image
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/background1.png'), // Replace with your background image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Main content
            SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'User Report Form',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: "Times New Roman",
                        ),
                      ),
                      const SizedBox(height: 35),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: _UserReportForm(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UserReportForm extends StatefulWidget {
  @override
  __UserReportFormState createState() => __UserReportFormState();
}

class __UserReportFormState extends State<_UserReportForm> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _reportController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserReportBloc, UserReportState>(
      listener: (context, state) {
        if (state is UserReportSubmitted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Report submitted successfully')),
          );
        } else if (state is UserReportError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: BlocBuilder<UserReportBloc, UserReportState>(
        builder: (context, state) {
          return Column(
            children: [
              _buildTextField(_nameController, 'Name', 'Enter your name'),
              const SizedBox(height: 10),
              _buildTextField(_emailController, 'Email', 'Enter your email'),
              const SizedBox(height: 10),
              _buildTextField(_reportController, 'Report', 'Enter your report',
                  maxLines: 5),
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton(
                    onPressed: state is UserReportSubmitting
                        ? null
                        : () {
                            final userReport = UserReport(
                              name: _nameController.text,
                              email: _emailController.text,
                              report: _reportController.text,
                            );
                            context
                                .read<UserReportBloc>()
                                .add(SubmitUserReport(userReport));
                          },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 24),
                      textStyle: const TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF3354A8), Color(0xFF7891CA)],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 24),
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, String hint,
      {int maxLines = 1}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            width: 2,
            style: BorderStyle.solid,
            color: Colors.grey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            width: 2,
            style: BorderStyle.solid,
            color: Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            width: 2,
            style: BorderStyle.solid,
            color: Colors.blue,
          ),
        ),
      ),
      maxLines: maxLines,
      style: const TextStyle(color: Colors.black),
    );
  }
}
