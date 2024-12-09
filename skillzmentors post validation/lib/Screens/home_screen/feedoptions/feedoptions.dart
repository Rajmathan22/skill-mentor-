import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillzmentors/Models/home_screen_model/feed_post.dart';
import 'package:skillzmentors/config/string/strings.dart';
import 'package:skillzmentors/config/Colors/colors.dart';
import 'package:skillzmentors/ViewModel/home_bloc/home_bloc.dart';

void showOptionsBottomSheet(BuildContext context, String postId) {
  final homeBloc = BlocProvider.of<HomeBloc>(context);

  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(15),
      ),
    ),
    builder: (context) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                homeBloc.add(FeedMuteClickedEvent(postId: postId));
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                margin: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    AppStrings.mute,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'TimesNewRoman'),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Center(
                      child: Text(
                        AppStrings.hide,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'TimesNewRoman'),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      homeBloc.add(FeedHideClickedEvent(postId: postId));
                    },
                  ),
                  Divider(height: 1, color: AppColors.grey),
                  ListTile(
                    title: Center(
                      child: Text(
                        AppStrings.block,
                        style: TextStyle(
                            color: AppColors.red,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'TimesNewRoman'),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      homeBloc.add(FeedBlockClickedEvent(postId: postId));
                    },
                  ),
                  Divider(height: 1, color: AppColors.grey),
                  ListTile(
                    title: Center(
                      child: Text(
                        AppStrings.report,
                        style: TextStyle(
                            color: AppColors.red,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'TimesNewRoman'),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      homeBloc.add(FeedReportClickedEvent(postId: postId));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
