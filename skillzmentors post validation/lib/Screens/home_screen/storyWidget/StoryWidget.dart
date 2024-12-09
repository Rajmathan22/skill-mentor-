import 'package:flutter/material.dart';
import 'package:skillzmentors/Models/home_screen_model/minestory.dart';
import 'package:skillzmentors/Screens/home_screen/storyWidget/you_story_widget.dart';
import 'package:skillzmentors/Models/home_screen_model/story_model.dart';
import 'package:skillzmentors/Screens/home_screen/storyWidget/storyviewpage.dart';
import 'package:skillzmentors/config/string/strings.dart';
import 'package:skillzmentors/config/Colors/colors.dart';
import 'package:skillzmentors/config/Images/jobes_image.dart';

class StoryWidget extends StatelessWidget {
  final List<Story> stories;
  final MineStory? mineStory;

  const StoryWidget({
    super.key,
    required this.stories,
    this.mineStory,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 60,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.lightBlue, AppColors.lightBlue],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                YourStoryWidget(mineStory: mineStory),
                ...stories.map((story) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => StoryViewPage(
                            stories: stories,
                            initialIndex: stories.indexOf(story),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  JobsImage.Story_circle,
                                  height: 70,
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                    _validateUrl(story.profileimg)
                                        ? story.profileimg!
                                        : AppStrings.defaultImageUrl,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            story.pseudo,
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 12, fontFamily: 'TimesNewRoman'),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _validateUrl(String? url) {
    if (url == null || url.isEmpty) return false;
    return Uri.tryParse(url)?.hasAbsolutePath ?? false;
  }
}
