import 'package:flutter/material.dart';
import 'package:skillzmentors/Screens/home_screen/storyWidget/storyviewpage.dart';
import 'package:skillzmentors/config/string/strings.dart';
import 'package:skillzmentors/Models/home_screen_model/story_model.dart';
import 'package:skillzmentors/config/Colors/colors.dart';
import 'package:skillzmentors/config/Images/jobes_image.dart';
import 'package:skillzmentors/Screens/home_screen/storyWidget/story_upload.dart';
import 'package:skillzmentors/Models/home_screen_model/minestory.dart';

class YourStoryWidget extends StatelessWidget {
  final MineStory? mineStory;

  const YourStoryWidget({Key? key, this.mineStory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (mineStory != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => StoryViewPage(
                stories: [
                  Story(
                    id: mineStory!.mineId,
                    pseudo: "Your Story",
                    profileimg: mineStory!.mineMedia.isNotEmpty
                        ? mineStory!.mineMedia[0].mediaUrl
                        : AppStrings.defaultImageUrl,
                    storyUrls: mineStory!.mineMedia
                        .map((media) => media.mediaUrl)
                        .toList(),
                    isLiked: mineStory!.isLiked,
                    isMineStory: true, 
                  ),
                ],
                initialIndex: 0,
              ),
            ),
          );
        } else {
          print("MineStory Tapped: No data available.");
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ImageSelectorPage(),
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
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
                      mineStory?.mineMedia.isNotEmpty ?? false
                          ? mineStory!.mineMedia[0].mediaUrl
                          : AppStrings.defaultImageUrl,
                    ),
                  ),
                  if (mineStory == null)
                    Positioned(
                      right: 4,
                      bottom: 4,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: AppColors.primaryBlue,
                        child: const Icon(
                          Icons.add,
                          color: AppColors.white,
                          size: 15,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Text(
              mineStory != null ? AppStrings.yourStory : AppStrings.yourStory,
              maxLines: 1,
              style: const TextStyle(fontSize: 12, fontFamily: 'TimesNewRoman'),
            ),
          ],
        ),
      ),
    );
  }
}
