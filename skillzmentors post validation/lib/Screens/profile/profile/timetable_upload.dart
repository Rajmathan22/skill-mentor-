import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimetableWidget extends StatefulWidget {
  const TimetableWidget({super.key});

  @override
  _TimetableWidgetState createState() => _TimetableWidgetState();
}

class _TimetableWidgetState extends State<TimetableWidget> {
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('saved_image');
    if (imagePath != null && File(imagePath).existsSync()) {
      setState(() {
        _selectedImage = File(imagePath);
      });
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });

      // Save the image path
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('saved_image', image.path);
    }
  }

  void _showImageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Selected Image'),
          content: _selectedImage != null
              ? Image.file(_selectedImage!)
              : const Text('No image selected'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timetable Image Upload'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: _pickImage,
          child: Container(
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(color: Colors.grey),
              image: _selectedImage != null
                  ? DecorationImage(
                      image: FileImage(_selectedImage!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: _selectedImage == null
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.upload, size: 40, color: Colors.grey),
                        Text(
                          'Tap to upload image',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : null,
          ),
        ),
      ),
      floatingActionButton: _selectedImage != null
          ? FloatingActionButton(
              onPressed: _showImageDialog,
              child: const Icon(Icons.image),
            )
          : null,
    );
  }
}
