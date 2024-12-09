import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:photo_view/photo_view.dart';

import 'package:skillzmentors/Components/AppBar/app_bar_withbackbutton.dart';

class ExamtableScreen extends StatefulWidget {
  const ExamtableScreen({super.key});

  @override
  _ExamtableScreenState createState() => _ExamtableScreenState();
}

class _ExamtableScreenState extends State<ExamtableScreen> {
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
            child: SingleChildScrollView(
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
                          'Timetable',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    // Add button
                    Center(
                      child: Column(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () async {
                              final picker = ImagePicker();
                              final pickedFile = await picker.pickImage(
                                  source: ImageSource.gallery);
                              if (pickedFile != null) {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setString(
                                    'timetableImage', pickedFile.path);
                                setState(() {});
                              }
                            },
                            icon: const Icon(Icons.add),
                            label: const Text('Upload Your Timetable'),
                          ),
                          const SizedBox(height: 20),
                          FutureBuilder(
                            future: SharedPreferences.getInstance(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                final prefs =
                                    snapshot.data as SharedPreferences;
                                final imagePath =
                                    prefs.getString('timetableImage');
                                if (imagePath != null) {
                                  return Image.file(File(imagePath));
                                } else {
                                  return const Text('No timetable uploaded');
                                }
                              } else {
                                return const CircularProgressIndicator();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Zoomable timetable image
                    FutureBuilder(
                      future: SharedPreferences.getInstance(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          final prefs = snapshot.data as SharedPreferences;
                          final imagePath = prefs.getString('timetableImage');
                          if (imagePath != null) {
                            return Container(
                              height: 400, // Set a fixed height for the PhotoView
                              child: PhotoView(
                                imageProvider: FileImage(File(imagePath)),
                                minScale: PhotoViewComputedScale.contained,
                                maxScale: PhotoViewComputedScale.covered * 4,
                              ),
                            );
                          } else {
                            return const Text('No timetable uploaded');
                          }
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
