import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillzmentors/Models/home_screen_model/feed_post.dart';
import 'package:skillzmentors/Models/home_screen_model/story_model.dart';
import 'package:http/http.dart' as http;
import 'package:skillzmentors/Models/home_screen_model/minestory.dart';
import 'package:skillzmentors/services/constant/constants.dart';
import 'package:skillzmentors/services/error/errors.dart';
import 'package:http_parser/http_parser.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<LoadMoreFeedsEvent>(loadMoreFeeds);
    on<NavigatetoNotificationPageEvent>(navigatetoNotificationPageEvent);
    on<NaviagateToNewPostEvent>(naviagateToNewPostEvent);
    on<FeedPostLikeClickedEvent>(feedPostLikeClickedEvent);
    on<FeedPostCommentClickedEvent>(feedPostCommentClickedEvent);
    on<FeedBlockClickedEvent>(feedBlockClickedEvent);
    on<FeedHideClickedEvent>(feedHideClickedEvent);
    on<FeedMuteClickedEvent>(feedMuteClickedEvent);
    on<FeedReportClickedEvent>(feedReportClickedEvent);
    on<StoryLikeClickedEvent>(storyLikeClickedEvent);
    on<UploadImageEvent>(uploadImage);
    on<DeleteStoryEvent>(deleteStoryEvent);
  }

  Future<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());

    try {
      final headers = header;

      final feedResponse = await http.get(
        Uri.parse('${baseUrl}feeds?page=1'),
        headers: headers,
      );

      final storyResponse = await http.get(
        Uri.parse('${baseUrl}stories'),
        headers: headers,
      );

      final mineStoryResponse = await http.get(
        Uri.parse('${baseUrl}stories/mine'),
        headers: headers,
      );

      if (feedResponse.statusCode == 200 &&
          storyResponse.statusCode == 200 &&
          mineStoryResponse.statusCode == 200) {
        final feedData = jsonDecode(feedResponse.body);
        final feeds = (feedData['feeds'] as List).map((e) {
          return FeedDataModel(
            id: e['id']?.toString() ?? '',
            pseudo: e['name'] ?? '',
            photo: e['medias']?.isNotEmpty == true
                ? e['medias'][0]['media_url'] ?? ''
                : '',
            time: e['created_at'] ?? '',
            photoProfile: e['medias']?.isNotEmpty == true
                ? e['medias'][0]['media_url'] ?? ''
                : '',
            description: e['description'] ?? '',
            likes: e['likes_count']?.toString() ?? '0',
            isLiked: e['isliked'] ?? false,
          );
        }).toList();

        final storyData = jsonDecode(storyResponse.body);
        final stories = (storyData['data'] as List).map((e) {
          return Story(
            id: e['id'] ?? '',
            pseudo: e['user_name'] ?? '',
            profileimg: e['story_media']?.isNotEmpty == true
                ? e['story_media'][0]['media_url']
                : '',
            storyUrls: (e['story_media'] as List)
                .map((media) => media['media_url'] as String)
                .toList(),
            isLiked: e['is_liked'] ?? false,
          );
        }).toList();

        final mineStoryData = jsonDecode(mineStoryResponse.body);

        emit(HomeLoadedSuccessfullyState(
          feeds: feeds,
          stories: stories,
          mineStory: mineStoryData['mine_story'] != null
              ? MineStory.fromJson(mineStoryData['mine_story'])
              : null,
        ));
      } else {
        handleApiError('Failed to load data.', null);
        emit(HomeErrorState());
      }
    } catch (error) {
      handleException('An error occurred while loading data: $error');
      emit(HomeErrorState());
    }
  }

  Future<void> loadMoreFeeds(
      LoadMoreFeedsEvent event, Emitter<HomeState> emit) async {
    if (state is! HomeLoadedSuccessfullyState) return;

    final currentState = state as HomeLoadedSuccessfullyState;
    emit(HomeFeedsPaginationState(
      feeds: currentState.feeds,
      stories: currentState.stories,
      mineStory: currentState.mineStory,
    ));

    try {
      final headers = header;

      final feedResponse = await http.get(
        Uri.parse('${baseUrl}feeds?page=${event.page}'),
        headers: headers,
      );

      if (feedResponse.statusCode == 200) {
        final feedData = jsonDecode(feedResponse.body);
        final newFeeds = (feedData['feeds'] as List).map((e) {
          return FeedDataModel(
            id: e['id']?.toString() ?? '',
            pseudo: e['name'] ?? '',
            photo: e['medias']?.isNotEmpty == true
                ? e['medias'][0]['media_url'] ?? ''
                : '',
            time: e['created_at'] ?? '',
            photoProfile: e['medias']?.isNotEmpty == true
                ? e['medias'][0]['media_url'] ?? ''
                : '',
            description: e['description'] ?? '',
            likes: e['likes_count']?.toString() ?? '0',
            isLiked: e['isliked'] ?? false,
          );
        }).toList();

        emit(HomeLoadedSuccessfullyState(
          feeds: [...currentState.feeds, ...newFeeds],
          stories: currentState.stories,
          mineStory: currentState.mineStory,
        ));
      } else {
        handleApiError('Failed to load more feeds.', null);
        emit(HomeErrorState());
      }
    } catch (error) {
      handleException('Error occurred while loading more feeds: $error');
      emit(HomeErrorState());
    }
  }

  FutureOr<void> navigatetoNotificationPageEvent(
      NavigatetoNotificationPageEvent event, Emitter<HomeState> emit) {
    print("Notification Clicked");
    emit(NavigatetoNotificationPageState());
  }

  FutureOr<void> naviagateToNewPostEvent(
      NaviagateToNewPostEvent event, Emitter<HomeState> emit) {
    emit(NaviagateToNewPostState());
    print("NewPostClicked");
  }

  Future<void> feedPostLikeClickedEvent(
      FeedPostLikeClickedEvent event, Emitter<HomeState> emit) async {
    final currentState = state;

    if (currentState is HomeLoadedSuccessfullyState) {
      final updatedFeeds = currentState.feeds.map((feed) {
        if (feed.id == event.postId) {
          final newLikes = feed.isLiked
              ? (int.parse(feed.likes ?? '0') - 1).toString()
              : (int.parse(feed.likes ?? '0') + 1).toString();
          return feed.copyWith(isLiked: !feed.isLiked, likes: newLikes);
        }
        return feed;
      }).toList();

      emit(HomeLoadedSuccessfullyState(
          feeds: updatedFeeds,
          stories: currentState.stories,
          mineStory: currentState.mineStory));

      try {
        final headers = header;

        final response = await http.post(
          Uri.parse('${baseUrl}feeds/${event.postId}/like'),
          headers: headers,
        );

        if (response.statusCode != 200) {
          handleApiError(
              'Failed to like the post. Status code: ${response.statusCode}',
              event.context);
        }
      } catch (error) {
        handleException('Error while liking the post: $error',
            context: event.context);
      }
    }
  }

  FutureOr<void> feedPostCommentClickedEvent(
      FeedPostCommentClickedEvent event, Emitter<HomeState> emit) {}

  FutureOr<void> feedBlockClickedEvent(
      FeedBlockClickedEvent event, Emitter<HomeState> emit) {
    print("Action: Block clicked on Feed ID: ${event.postId}");
  }

  FutureOr<void> feedHideClickedEvent(
      FeedHideClickedEvent event, Emitter<HomeState> emit) {
    print("Action: Hide clicked on Feed ID: ${event.postId}");
  }

  FutureOr<void> feedMuteClickedEvent(
      FeedMuteClickedEvent event, Emitter<HomeState> emit) {
    print("Action: Mute clicked on Feed ID: ${event.postId}");
  }

  FutureOr<void> feedReportClickedEvent(
      FeedReportClickedEvent event, Emitter<HomeState> emit) {
    print("Action: report clicked on Feed ID: ${event.postId}");
  }

  Future<void> storyLikeClickedEvent(
      StoryLikeClickedEvent event, Emitter<HomeState> emit) async {
    if (state is! HomeLoadedSuccessfullyState) return;

    final currentState = state as HomeLoadedSuccessfullyState;
    final updatedStories = currentState.stories.map((story) {
      if (story.id == event.storyId) {
        return story.copyWith(isLiked: !story.isLiked);
      }
      return story;
    }).toList();

    emit(HomeLoadedSuccessfullyState(
      feeds: currentState.feeds,
      stories: updatedStories,
      mineStory: currentState.mineStory,
    ));

    try {
      final headers = header;
      final response = await http.post(
        Uri.parse('${baseUrl}stories/${event.storyId}/like'),
        headers: headers,
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to like story.');
      }
    } catch (error) {
      final revertedStories = currentState.stories.map((story) {
        if (story.id == event.storyId) {
          return story.copyWith(isLiked: !story.isLiked);
        }
        return story;
      }).toList();

      emit(HomeLoadedSuccessfullyState(
        feeds: currentState.feeds,
        stories: revertedStories,
        mineStory: currentState.mineStory,
      ));
    }
  }

  Future<void> uploadImage(
      UploadImageEvent event, Emitter<HomeState> emit) async {
    try {
      final uri =
          Uri.parse('https://skillzmentors.vercel.app/api/api/stories/');
      final request = http.MultipartRequest('POST', uri);
      request.headers.addAll(header);
      request.files.add(
        http.MultipartFile.fromBytes(
          'media[]',
          event.imageData,
          filename: 'image.jpg',
          contentType: MediaType('image', 'jpeg'),
        ),
      );
      final response = await request.send();

      if (response.statusCode == 201) {
        add(HomeInitialEvent());
      } else {
        throw Exception('Failed to upload image.');
      }
    } catch (error) {
      handleException('Error during upload: $error');
      emit(HomeErrorState());
    }
  }

  Future<void> deleteStoryEvent(
      DeleteStoryEvent event, Emitter<HomeState> emit) async {
    try {
      final response = await http.delete(
        Uri.parse('${baseUrl}stories/${event.storyId}'),
        headers: header,
      );

      if (response.statusCode == 200) {
        add(HomeInitialEvent());
      } else {
        throw Exception('Failed to delete the story.');
      }
    } catch (e) {
      handleException('Error deleting story: $e');
      emit(HomeErrorState());
    }
  }
}
