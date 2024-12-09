part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class LoadMoreFeedsEvent extends HomeEvent {
  final int page; // Page number for pagination

  LoadMoreFeedsEvent({required this.page});
}

class NavigatetoNotificationPageEvent extends HomeEvent {}

class NaviagateToNewPostEvent extends HomeEvent {}

class FeedPostLikeClickedEvent extends HomeEvent {
  final String postId;
  final BuildContext context; // Add context

  FeedPostLikeClickedEvent({required this.postId, required this.context});
}

class FeedPostCommentClickedEvent extends HomeEvent {}

class FeedMuteClickedEvent extends HomeEvent {
  final String postId;

  FeedMuteClickedEvent({required this.postId});
}

class FeedHideClickedEvent extends HomeEvent {
  final String postId;

  FeedHideClickedEvent({required this.postId});
}

class FeedBlockClickedEvent extends HomeEvent {
  final String postId;

  FeedBlockClickedEvent({required this.postId});
}

class FeedReportClickedEvent extends HomeEvent {
  final String postId;

  FeedReportClickedEvent({required this.postId});
}

class StoryLikeClickedEvent extends HomeEvent {
  final String storyId;

  StoryLikeClickedEvent({required this.storyId});
}

class UploadImageEvent extends HomeEvent {
  final Uint8List imageData;

  UploadImageEvent({required this.imageData});
}

class DeleteStoryEvent extends HomeEvent {
  final String storyId;

  DeleteStoryEvent(this.storyId);
}
