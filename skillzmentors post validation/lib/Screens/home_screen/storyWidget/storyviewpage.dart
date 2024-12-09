import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillzmentors/Screens/home_screen/storyWidget/favorite_icon_button.dart';
import 'package:skillzmentors/Models/home_screen_model/story_model.dart';
import 'package:skillzmentors/config/string/strings.dart';
import 'package:skillzmentors/ViewModel/home_bloc/home_bloc.dart';
import 'package:skillzmentors/config/Colors/colors.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';

class StoryViewPage extends StatefulWidget {
  final List<Story> stories;
  final int initialIndex;

  StoryViewPage({required this.stories, required this.initialIndex});

  @override
  _StoryViewPageState createState() => _StoryViewPageState();
}

class _StoryViewPageState extends State<StoryViewPage> {
  late StoryController _storyController;

  @override
  void initState() {
    super.initState();
    _storyController = StoryController();
  }

  @override
  void dispose() {
    _storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentStory = widget.stories[widget.initialIndex];

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.white),
        backgroundColor: AppColors.lightBlue,
        title: Row(
          children: [
            CircleAvatar(
              radius: 16, // Profile image size
              backgroundImage: NetworkImage(
                currentStory.profileimg ?? AppStrings.defaultImageUrl,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              currentStory.pseudo,
              style: TextStyle(fontSize: 18, color: AppColors.white),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: AppColors.white,
              size: 24,
            ),
            onPressed: () {
              print("Options menu clicked");
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          StoryView(
            storyItems:
                currentStory.storyUrls.where((url) => url != null).map((url) {
              return StoryItem.pageImage(
                url: url!,
                controller: _storyController,
                caption: Text(
                  "Story by ${currentStory.pseudo}",
                  style: const TextStyle(color: Colors.white),
                ),
                duration: const Duration(seconds: 15), // Play for 15 seconds
              );
            }).toList(),
            controller: _storyController,
            onComplete: () {
              // Navigate to the next story or exit
              if (widget.initialIndex < widget.stories.length - 1) {
                Future.delayed(const Duration(milliseconds: 500), () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StoryViewPage(
                        stories: widget.stories,
                        initialIndex: widget.initialIndex + 1,
                      ),
                    ),
                  );
                });
              } else {
                Navigator.of(context).pop();
              }
            },
            progressPosition: ProgressPosition.top,
            repeat: false,
          ),
          Positioned(
            bottom: 25,
            right: 16,
            child: currentStory.isMineStory
                ? IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 28,
                    ),
                    onPressed: () {
                      // Pause the story when the dialog is opened
                      _storyController.pause();

                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Delete Story"),
                          content: Text(
                              "Are you sure you want to delete this story?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                // Resume the story when dialog is dismissed
                                _storyController.play();
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                context
                                    .read<HomeBloc>()
                                    .add(DeleteStoryEvent(currentStory.id));
                                // Call delete API or handle deletion
                                print("Story deleted");
                                Navigator.of(context).pop(); // Close the dialog
                                Navigator.of(context)
                                    .pop(); // Close StoryViewPage
                              },
                              child: Text("Delete"),
                            ),
                          ],
                        ),
                      ).then((_) {
                        // Resume the story if the dialog is dismissed by tapping outside or other means
                        _storyController.play();
                      });
                    },
                  )
                : FavoriteIconButton(story: currentStory),
          )
        ],
      ),
    );
  }
}
