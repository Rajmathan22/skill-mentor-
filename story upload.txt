import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_editor_plus/options.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skillzmentors/Screens/home_screen/home.dart';
import 'dart:typed_data';

import 'package:skillzmentors/ViewModel/home_bloc/home_bloc.dart';

void main() {
  runApp(
    const MaterialApp(
      home: ImageSelectorPage(),
    ),
  );
}

class ImageSelectorPage extends StatefulWidget {
  const ImageSelectorPage({super.key});

  @override
  _ImageSelectorPageState createState() => _ImageSelectorPageState();
}

class _ImageSelectorPageState extends State<ImageSelectorPage> {
  Uint8List? selectedImageData;
  Uint8List? editedImageData;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pickImage(context);
    });
  }

  Future<void> pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();

    XFile? selectedImage = await showModalBottomSheet<XFile?>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text(
                  "Take a Photo",
                  style: TextStyle(fontFamily: 'TimesNewRoman'),
                ),
                onTap: () async {
                  Navigator.of(context).pop(
                    await picker.pickImage(source: ImageSource.camera),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text(
                  "Choose from Gallery",
                  style: TextStyle(fontFamily: 'TimesNewRoman'),
                ),
                onTap: () async {
                  Navigator.of(context).pop(
                    await picker.pickImage(source: ImageSource.gallery),
                  );
                },
              ),
            ],
          ),
        );
      },
    );

    if (selectedImage != null) {
      Uint8List? imageData = await selectedImage.readAsBytes();
      if (imageData != null) {
        setState(() {
          selectedImageData = imageData;
        });
        showImageOptions(context, imageData);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No image selected")),
      );
    }
  }

  void showImageOptions(BuildContext context, Uint8List imageData) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.upload),
                title: const Text("Upload Image"),
                onTap: () {
                  Navigator.of(context).pop();
                  uploadImage(imageData);
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text(
                  "Edit Image",
                  style: TextStyle(fontFamily: 'TimesNewRoman'),
                ),
                onTap: () async {
                  Navigator.of(context).pop();

                  Uint8List? editedImage = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageEditor(
                        image: imageData,
                        cropOption: const CropOption(
                          reversible: false,
                        ),
                      ),
                    ),
                  );

                  if (editedImage != null && mounted) {
                    setState(() {
                      editedImageData = editedImage;
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void uploadImage(Uint8List imageData) {
    BlocProvider.of<HomeBloc>(context)
        .add(UploadImageEvent(imageData: imageData));

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
      (route) => false,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Uploading image...")),
    );
  }

  Future<bool> _onWillPop() async {
    if (selectedImageData != null || editedImageData != null) {
      return await showDialog<bool>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  "Are you sure?",
                  style: TextStyle(fontFamily: 'TimesNewRoman'),
                ),
                content: const Text(
                  "Do you want to discard changes?",
                  style: TextStyle(fontFamily: 'TimesNewRoman'),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text("Continue"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text("Discard"),
                  ),
                ],
              );
            },
          ) ??
          false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Image Selector"),
          centerTitle: true,
        ),
        body: BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is HomeUploadSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Image uploaded successfully!")),
              );

              // Navigate to home screen
            } else if (state is HomeErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Failed to upload image")),
              );
            }
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (editedImageData != null)
                  Image.memory(editedImageData!, fit: BoxFit.contain)
                else if (selectedImageData != null)
                  Image.memory(selectedImageData!, fit: BoxFit.contain)
                else
                  const Text("Select an image to get started."),
                const SizedBox(height: 20),
                if (editedImageData != null || selectedImageData != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          uploadImage(editedImageData ?? selectedImageData!);
                        },
                        child: const Text("Upload"),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () async {
                          bool discard = await _onWillPop();
                          if (discard) {
                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: const Text("Discard"),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
