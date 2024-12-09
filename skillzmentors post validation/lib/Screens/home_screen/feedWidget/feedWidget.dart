import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillzmentors/Models/home_screen_model/feed_post.dart';
import 'package:skillzmentors/Screens/home_screen/feedoptions/feedoptions.dart';
import 'package:skillzmentors/config/string/strings.dart';
import 'package:skillzmentors/ViewModel/home_bloc/home_bloc.dart';
import 'package:skillzmentors/config/Colors/colors.dart';

class FeedTileWidget extends StatelessWidget {
  final FeedDataModel feedDataModel;
  final HomeBloc homeBloc = HomeBloc();

  FeedTileWidget({super.key, required this.feedDataModel});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: screenWidth * 0.03,
      ),
      color: AppColors.cardBackground,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Avatar and Info
            Row(
              children: [
                CircleAvatar(
                  backgroundImage:
                      NetworkImage(feedDataModel.photoProfile ?? ''),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      feedDataModel.pseudo,
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                          fontFamily: 'TimesNewRoman'),
                    ),
                    Text(
                      feedDataModel.time,
                      style: TextStyle(
                          fontSize: 13.0,
                          color: AppColors.textSecondary,
                          fontFamily: 'TimesNewRoman'),
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.more_vert, color: AppColors.buttonIcon),
                  onPressed: () {
                    showOptionsBottomSheet(context, feedDataModel.id);
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0),

            Text(
              feedDataModel.description ?? '',
              style: TextStyle(
                  fontSize: 15.0,
                  color: AppColors.textPrimary,
                  fontFamily: 'TimesNewRoman'),
            ),
            SizedBox(height: 12.0),

            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      color: Colors.black.withOpacity(0.9),
                      child: Center(
                        child: Hero(
                          tag: 'zoomImage_${feedDataModel.id}',
                          child: Image.network(
                            feedDataModel.photo ?? '',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              child: Hero(
                tag: 'zoomImage_${feedDataModel.id}',
                child: Container(
                  height: 200.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(feedDataModel.photo ?? ''),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),

            SizedBox(height: 16.0),

            // Likes and Comments
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '   ${AppStrings.likeSymbol} ${feedDataModel.likes ?? '0'}',
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                      fontFamily: 'TimesNewRoman'),
                ),
              ],
            ),
            SizedBox(height: 5),

            Row(
              children: [
                IconButton(
                  onPressed: () {
                    BlocProvider.of<HomeBloc>(context).add(
                      FeedPostLikeClickedEvent(
                        postId: feedDataModel.id,
                        context: context, // Pass the context for the SnackBar
                      ),
                    );
                  },
                  icon: Icon(
                    feedDataModel.isLiked
                        ? Icons.favorite
                        : Icons.favorite_outline,
                    color: feedDataModel.isLiked
                        ? Colors.red
                        : AppColors.buttonIcon,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
