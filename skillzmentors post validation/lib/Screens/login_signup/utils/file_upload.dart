import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

class FileUploadField extends StatefulWidget {
  final String title;
  final IconData? iconData;
  final Function(String)? onUploadComplete;
  const FileUploadField({
    super.key,
    required this.title,
    this.iconData,
    this.onUploadComplete,
  });

  @override
  State<FileUploadField> createState() => _FileUploadFieldState();
}

class _FileUploadFieldState extends State<FileUploadField> {
  File? _selectedFile;
  Uint8List? _selectedFileBytes;
  bool _isUploading = false;
  bool _isUploaded = false;

  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        setState(() {
          if (kIsWeb) {
            _selectedFileBytes = result.files.single.bytes;
          } else {
            _selectedFile = File(result.files.single.path!);
          }
          _isUploaded = false;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error picking file: $e")),
      );
    }
  }

  Future<void> uploadFile() async {
    if (_selectedFile == null && _selectedFileBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a file first")),
      );
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      String uploadUrl = 'https://your-server.com/upload';

      FormData? formData;

      if (_selectedFile != null) {
        formData = FormData.fromMap({
          "file": await MultipartFile.fromFile(
            _selectedFile!.path,
            filename: _selectedFile!.path.split('/').last,
          ),
        });
      } else if (_selectedFileBytes != null) {
        formData = FormData.fromMap({
          "file": MultipartFile.fromBytes(
            _selectedFileBytes!,
            filename: "upload_file",
          ),
        });
      }

      if (formData != null) {
        Dio dio = Dio();
        Response response = await dio.post(uploadUrl, data: formData);

        if (response.statusCode == 200) {
          setState(() {
            _isUploaded = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("File uploaded successfully")),
          );
          if (widget.onUploadComplete != null) {
            widget.onUploadComplete!("upload_file");
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed to upload file")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No file selected for upload")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error uploading file: $e")),
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: "Times New Roman",
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: pickFile,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Colors.green),
            ),
            child: Row(
              children: [
                if (widget.iconData != null)
                  Icon(widget.iconData, color: const Color(0xFF00C8C8)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _selectedFile != null || _selectedFileBytes != null
                        ? "File selected"
                        : "Select a file",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Times New Roman",
                      color:
                          (_selectedFile != null || _selectedFileBytes != null)
                              ? Colors.green
                              : Colors.grey,
                    ),
                  ),
                ),
                if (_isUploading)
                  const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                else if (_isUploaded)
                  const Icon(Icons.check, color: Colors.black)
                else
                  TextButton(
                    onPressed: uploadFile,
                    child: const Text(
                      "Upload",
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Times New Roman"),
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
