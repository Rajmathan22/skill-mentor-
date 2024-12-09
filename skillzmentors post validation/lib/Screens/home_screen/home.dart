import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:skillzmentors/Components/bottom_navigation_bar/custom_bottom_appbar.dart';
import 'package:skillzmentors/Screens/home_screen/feedWidget/feedWidget.dart';
import 'package:skillzmentors/Screens/home_screen/storyWidget/StoryWidget.dart';
import 'package:skillzmentors/Screens/home_screen/new_post/new_post.dart';
import 'package:skillzmentors/config/string/strings.dart';
import 'package:skillzmentors/Screens/home_screen/notification_screen/notifiaction_screen.dart';
import 'package:skillzmentors/ViewModel/home_bloc/home_bloc.dart';
import 'package:skillzmentors/config/Colors/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  int currentPage = 1; // Track the current page for pagination

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    BlocProvider.of<HomeBloc>(context).add(HomeInitialEvent());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Trigger pagination when scrolled to the end
      currentPage++; // Increment page number
      BlocProvider.of<HomeBloc>(context)
          .add(LoadMoreFeedsEvent(page: currentPage));
    }
  }

  Future<void> _onRefresh() async {
    currentPage = 1; // Reset to the first page
    BlocProvider.of<HomeBloc>(context).add(HomeInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is NaviagateToNewPostState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PostScreen()));
        } else if (state is NavigatetoNotificationPageState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const NotificationScreen()));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return Scaffold(
              body: Center(
                  child: SpinKitCircle(
                color: Colors.blue,
                size: 40.0,
              )),
            );
          case HomeLoadedSuccessfullyState:
          case HomeFeedsPaginationState:
            final successState = state as HomeLoadedSuccessfullyState;
            final isPaginating = state is HomeFeedsPaginationState;

            return Scaffold(
              backgroundColor: AppColors.white,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                titleSpacing: 0,
                backgroundColor: AppColors.white,
                elevation: 0,
                title: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryBlue,
                        AppColors.lightBlue,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Text(
                        AppStrings.appName,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          BlocProvider.of<HomeBloc>(context)
                              .add(NavigatetoNotificationPageEvent());
                        },
                        icon: const Icon(Icons.notifications,
                            color: AppColors.white),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PostScreen()));
                        },
                        icon: const Icon(Icons.add_box_outlined,
                            color: AppColors.white),
                      ),
                      const SizedBox(width: 5),
                    ],
                  ),
                ),
                iconTheme: const IconThemeData(
                  color: AppColors.black,
                ),
              ),
              body: RefreshIndicator(
                onRefresh: _onRefresh,
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: successState.feeds.length +
                      2, // Add space for StoryWidget and loading indicator
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return StoryWidget(
                        stories: successState.stories,
                        mineStory: successState.mineStory,
                      );
                    }
                    if (index <= successState.feeds.length) {
                      return FeedTileWidget(
                          feedDataModel: successState.feeds[index - 1]);
                    }
                    // Loading indicator at the bottom
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: isPaginating
                            ? SpinKitCircle(
                                color: AppColors.lightBlue,
                                size: 50.0,
                              )
                            : const SizedBox.shrink(),
                      ),
                    );
                  },
                ),
              ),
            );
          case HomeErrorState:
            return const Scaffold(
              body: Center(child: Text(AppStrings.error)),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
