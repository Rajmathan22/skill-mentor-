import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillzmentors/Components/AppBar/app_bar_withbackbutton.dart';
import 'package:skillzmentors/Models/proflie_model/leave_model.dart';
import 'package:skillzmentors/ViewModel/Profilebloc/leave_bloc.dart';
import 'package:skillzmentors/ViewModel/Profilebloc/leave_state.dart';
import 'package:skillzmentors/ViewModel/Profilebloc/leave_event.dart';

class LeaveScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _ToController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  String? _leaveType;
  String? _selectedFileName;

  LeaveScreen({super.key});

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
                        'Apply Leave',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: "Times New Roman",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  // Leave form
                  _buildLeaveForm(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaveForm(BuildContext context) {
    return BlocListener<LeaveBloc, LeaveState>(
      listener: (context, state) {
        if (state is LeaveSubmitted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Leave submitted successfully')),
          );
        } else if (state is LeaveError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Leave Form',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: "Times New Roman",
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(
                  fontFamily: "Times New Roman",
                ),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _ToController,
              decoration: const InputDecoration(
                labelText: 'To:',
                labelStyle: TextStyle(
                  fontFamily: "Times New Roman",
                ),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _reasonController,
              decoration: const InputDecoration(
                labelText: 'Reason',
                labelStyle: TextStyle(
                  fontFamily: "Times New Roman",
                ),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _leaveType,
              items: ['Casual Leave', 'Sick Leave']
                  .map((leaveType) => DropdownMenuItem(
                        value: leaveType,
                        child: Text(leaveType),
                      ))
                  .toList(),
              onChanged: (value) {
                _leaveType = value;
              },
              decoration: const InputDecoration(
                labelText: 'Leave Type',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: _startDate == null
                          ? 'Start Date'
                          : _startDate!.toLocal().toString().split(' ')[0],
                      labelStyle: const TextStyle(
                        fontFamily: "Times New Roman",
                      ),
                      border: const OutlineInputBorder(),
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        _startDate = pickedDate;
                        (context as Element).markNeedsBuild();
                      }
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: _endDate == null
                          ? 'End Date'
                          : _endDate!.toLocal().toString().split(' ')[0],
                      labelStyle: const TextStyle(
                        fontFamily: "Times New Roman",
                      ),
                      border: const OutlineInputBorder(),
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        _endDate = pickedDate;
                        (context as Element).markNeedsBuild();
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            ElevatedButton.icon(
              onPressed: () async {
                final result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'png'],
                );
                if (result != null) {
                  final file = result.files.first;
                  _selectedFileName = file.name;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Selected file: ${file.name}')),
                  );
                  (context as Element).markNeedsBuild();
                }
              },
              icon: const Icon(Icons.upload_file),
              label: Text(
                _selectedFileName == null
                    ? 'Upload Proof Document'
                    : _selectedFileName!,
                style: const TextStyle(
                  fontFamily: "Times New Roman",
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                minimumSize: const Size(
                    double.infinity, 50), // Set the width to fill the parent
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Container(
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
                    if (_nameController.text.isNotEmpty &&
                        _reasonController.text.isNotEmpty &&
                        _startDate != null &&
                        _endDate != null &&
                        _leaveType != null) {
                      final leave = Leave(
                        name: _nameController.text,
                        reason: _reasonController.text,
                        startDate: _startDate!,
                        endDate: _endDate!,
                        leaveType: _leaveType!,
                      );
                      context.read<LeaveBloc>().add(SubmitLeave(leave));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please fill all fields')),
                      );
                    }
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
                      'Submit Leave',
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: "Times New Roman",
                        color: Colors.white,
                      ),
                    ),
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
