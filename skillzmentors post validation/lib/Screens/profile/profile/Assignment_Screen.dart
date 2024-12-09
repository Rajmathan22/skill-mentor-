import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillzmentors/Components/AppBar/app_bar_withbackbutton.dart';
import 'package:skillzmentors/Models/proflie_model/assignment_model.dart';
import 'package:skillzmentors/Screens/profile/profile/Announcment_screen.dart';
import 'package:skillzmentors/Screens/profile/profile/assignmentSubmission_screen.dart';
import 'package:skillzmentors/ViewModel/Profilebloc/announcement_bloc.dart';
import 'package:skillzmentors/ViewModel/Profilebloc/announcement_event.dart';
import 'package:skillzmentors/ViewModel/Profilebloc/assignment_bloc.dart';
import 'package:skillzmentors/ViewModel/Profilebloc/assignment_state.dart';
import 'package:skillzmentors/ViewModel/Profilebloc/assignment_event.dart';
class AssignmentScreen extends StatelessWidget {
  const AssignmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back icon and title
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Assignment',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: "Times New Roman",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  // Assignment cards
                  Expanded(
                    child: BlocBuilder<AssignmentBloc, AssignmentState>(
                      builder: (context, state) {
                        if (state is AssignmentLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is AssignmentLoaded) {
                          return ListView(
                            children: state.assignments.map((assignment) {
                              return buildAssignmentCard(context, assignment);
                            }).toList(),
                          );
                        } else if (state is AssignmentError) {
                          return Center(child: Text(state.message));
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAssignmentCard(BuildContext context, Assignment assignment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Subject label
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              assignment.subject,
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontFamily: "Times New Roman",
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Topic
          Text(
            assignment.topic,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: "Times New Roman",
            ),
          ),
          const SizedBox(height: 8),
          // Dates
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Assign Date',
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: "Times New Roman",
                ),
              ),
              Text(
                assignment.assignDate,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "Times New Roman",
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Last Submission Date',
                style: TextStyle(
                    color: Colors.grey, fontFamily: "Times New Roman"),
              ),
              Text(
                assignment.lastDate,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "Times New Roman",
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Submit button
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF3354A8), Color(0xFF7891CA)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) =>
                          AssignmentBloc()..add(LoadAssignments()),
                      child: SubmissionPage(),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Center(
                child: Text(
                  'TO BE SUBMITTED',
                  style: TextStyle(
                      fontSize: 17,
                      fontFamily: "Times New Roman",
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
