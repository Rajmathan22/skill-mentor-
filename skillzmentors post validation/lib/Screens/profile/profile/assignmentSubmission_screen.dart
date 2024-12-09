import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillzmentors/Components/AppBar/app_bar_withbackbutton.dart';
import 'package:skillzmentors/Models/proflie_model/assignment_model.dart';
import 'package:skillzmentors/ViewModel/Profilebloc/assignment_bloc.dart';
import 'package:skillzmentors/ViewModel/Profilebloc/assignment_event.dart';
import 'package:skillzmentors/ViewModel/Profilebloc/assignment_state.dart';

class SubmissionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AssignmentBloc()..add(LoadAssignments()),
      child: Scaffold(
        appBar: const AppBarWithBackButton(),
        body: BlocBuilder<AssignmentBloc, AssignmentState>(
          builder: (context, state) {
            if (state is AssignmentLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AssignmentLoaded) {
              final assignments = state.assignments;
              return ListView.builder(
                itemCount: assignments.length,
                itemBuilder: (context, index) {
                  final assignment = assignments[index];
                  return SubmissionTaskWidget(assignment: assignment);
                },
              );
            } else if (state is AssignmentError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text('No Assignments Found'));
          },
        ),
      ),
    );
  }
}

class SubmissionTaskWidget extends StatefulWidget {
  final Assignment assignment;

  const SubmissionTaskWidget({Key? key, required this.assignment})
      : super(key: key);

  @override
  _SubmissionTaskWidgetState createState() => _SubmissionTaskWidgetState();
}

class _SubmissionTaskWidgetState extends State<SubmissionTaskWidget> {
  String? _uploadedFileName;
  final TextEditingController _remarksController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 4,
      color: Colors.white,
      shadowColor: Colors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.assignment.topic,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.assignment.subject,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.attach_file, color: Colors.blue),
                  onPressed: () async {
                    // Simulating file picker functionality
                    // You can replace this with the actual file picker logic
                    setState(() {
                      _uploadedFileName = 'example_file.pdf';
                    });
                  },
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: _remarksController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: _uploadedFileName ?? 'Write Something',
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.blue.shade50,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<AssignmentBloc>(context)
                    .add(SubmitAssignment(widget.assignment.subject));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Assignment Submitted')),
                );
              },
              child: const Text(
                'Submit',
                style: TextStyle(
                    fontFamily: "Times New Roman", color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Submitted Date:', style: TextStyle(fontSize: 14)),
                Text(
                  '${DateTime.now().toLocal()}'.split(' ')[0], // Today's date
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Verified by:', style: TextStyle(fontSize: 14)),
                Text('In Process', style: TextStyle(fontSize: 14)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Marks:', style: TextStyle(fontSize: 14)),
                Text('In Process', style: TextStyle(fontSize: 14)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
