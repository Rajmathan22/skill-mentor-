part of 'home_bloc.dart';

@immutable
abstract class HomeState {
  get feeds => null;

  get mineStory => null;
}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedSuccessfullyState extends HomeState {
  final List<FeedDataModel> feeds;
  final List<Story> stories;
  final MineStory? mineStory;

  HomeLoadedSuccessfullyState({
    required this.feeds,
    required this.stories,
    this.mineStory,
  });
}

class HomeLoadingMoreFeedsState extends HomeState {}

class HomeFeedsPaginationState extends HomeLoadedSuccessfullyState {
  HomeFeedsPaginationState({
    required List<FeedDataModel> feeds,
    required List<Story> stories,
    MineStory? mineStory,
  }) : super(feeds: feeds, stories: stories, mineStory: mineStory);
}

class HomeUploadSuccessState extends HomeState {}

class HomeErrorState extends HomeState {}

class NavigatetoNotificationPageState extends HomeActionState {}

class NaviagateToNewPostState extends HomeActionState {}

class FeedPostLikedState extends HomeActionState {
  final String postId;
  final bool isLiked;

  FeedPostLikedState({required this.postId, required this.isLiked});
}
