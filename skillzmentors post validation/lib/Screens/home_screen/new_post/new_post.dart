import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillzmentors/config/string/strings.dart';
import 'package:skillzmentors/ViewModel/new_post_bloc/new_post_bloc.dart';
import 'package:skillzmentors/ViewModel/new_post_bloc/new_post_event.dart';
import 'package:skillzmentors/ViewModel/new_post_bloc/new_post_state.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key}) : super(key: key);

  void _showDiscardDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Discard Post?'),
        content: const Text(
          'Are you sure you want to discard your changes?',
          style: TextStyle(fontFamily: 'TimesNewRoman'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Discard'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          "Create New Post",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => _showDiscardDialog(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward, color: Colors.black),
            onPressed: () {
              final state = context.read<PostBloc>().state;

              if (state is PostLoaded) {
                // Perform validation
                if (state.description.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Please enter a description.')),
                  );
                  return;
                }

                if (state.selectedImages.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Please add at least one media file.')),
                  );
                  return;
                }

                context.read<PostBloc>().add(UploadDataEvent());
              }
            },
          ),
        ],
      ),
      body: BlocConsumer<PostBloc, PostState>(
        listener: (context, state) {
          if (state is PostUploadedSuccessfully) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Post uploaded successfully!')),
            );
            context.read<PostBloc>().add(PostInitialEvent());
            Navigator.of(context).pop();
          } else if (state is PostError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is PostLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 24,
                          backgroundImage:
                              NetworkImage(AppStrings.defaultImageUrl),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "willi hooha",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            DropdownButton<String>(
                              value: state.isPrivate ? "Private" : "Public",
                              items: const [
                                DropdownMenuItem(
                                  value: "Public",
                                  child: Text("Public"),
                                ),
                                DropdownMenuItem(
                                  value: "Private",
                                  child: Text("Private"),
                                ),
                              ],
                              onChanged: (value) {
                                context.read<PostBloc>().add(
                                      TogglePrivacyEvent(
                                          isPrivate: value == "Private"),
                                    );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      style: const TextStyle(fontFamily: 'TimesNewRoman'),
                      decoration: const InputDecoration(
                        hintText: "What do you want to share?",
                        border: InputBorder.none,
                      ),
                      maxLines: 3,
                      onChanged: (text) {
                        context
                            .read<PostBloc>()
                            .add(UpdateDescriptionEvent(text));
                      },
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        context.read<PostBloc>().add(PickImagesEvent());
                      },
                      child: state.selectedImages.isEmpty
                          ? Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.add_photo_alternate,
                                      color: Colors.grey),
                                  SizedBox(height: 8),
                                  Text("Add Media",
                                      style: TextStyle(color: Colors.grey)),
                                ],
                              ),
                            )
                          : SizedBox(
                              height: 200,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.selectedImages.length,
                                itemBuilder: (context, index) {
                                  final image = state.selectedImages[index];
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: kIsWeb
                                          ? Image.network(
                                              image.path,
                                              fit: BoxFit.cover,
                                              width: 150,
                                              height: 150,
                                            )
                                          : Image.file(
                                              File(image.path),
                                              fit: BoxFit.cover,
                                              width: 150,
                                              height: 150,
                                            ),
                                    ),
                                  );
                                },
                              ),
                            ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 10),
                    _buildOptionRow(Icons.person_add, "Tag People"),
                    _buildOptionRow(Icons.location_on, "Add Location"),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildOptionRow(IconData icon, String text) {
    return GestureDetector(
      onTap: () {
        // Handle option tap
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey),
            const SizedBox(width: 12),
            Text(text, style: const TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
