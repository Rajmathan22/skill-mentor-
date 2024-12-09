import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:skillzmentors/ViewModel/home_bloc/home_bloc.dart';
import 'package:skillzmentors/config/Colors/colors.dart';
import 'package:skillzmentors/Models/home_screen_model/story_model.dart';

class FavoriteIconButton extends StatefulWidget {
  final Story story;

  const FavoriteIconButton({Key? key, required this.story}) : super(key: key);

  @override
  _FavoriteIconButtonState createState() => _FavoriteIconButtonState();
}

class _FavoriteIconButtonState extends State<FavoriteIconButton> {
  late bool isLiked; // Local state for optimistic UI update

  @override
  void initState() {
    super.initState();
    isLiked = widget.story.isLiked; // Initialize with the current state
  }

  void _toggleLike() {
    setState(() {
      // Optimistically toggle the like state
      isLiked = !isLiked;
    });

    // Dispatch the event to the Bloc
    BlocProvider.of<HomeBloc>(context).add(
      StoryLikeClickedEvent(storyId: widget.story.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isLiked ? Icons.favorite : Icons.favorite_border_outlined,
        size: 32,
        color: isLiked ? Colors.red : Colors.white,
      ),
      onPressed: _toggleLike,
    );
  }
}
