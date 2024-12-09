import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:skillzmentors/Components/AppBar/default_app_bar.dart';
import 'package:skillzmentors/Screens/event_screen/event_filter_component.dart';
import 'package:skillzmentors/Screens/event_screen/event_type_model.dart';
import 'package:skillzmentors/Screens/event_screen/event_view.dart';
import 'package:skillzmentors/Screens/event_screen/events_model.dart';
import 'package:skillzmentors/Screens/event_screen/location_component.dart';
import 'package:skillzmentors/Screens/event_screen/test_data.dart';
import 'package:skillzmentors/ViewModel/event_bloc/event_bloc.dart';
import 'package:skillzmentors/ViewModel/event_bloc/event_bloc_events.dart';
import 'package:skillzmentors/ViewModel/event_bloc/event_bloc_states.dart';
import 'package:skillzmentors/config/Colors/colors.dart';
import 'event_post.dart';
import 'event_type_component.dart';
import 'events_component.dart';
import 'package:flutter/foundation.dart' as foundation;

class HomeScreenEvent extends StatefulWidget {
  const HomeScreenEvent({Key? key}) : super(key: key);

  @override
  _HomeScreenEventState createState() => _HomeScreenEventState();
}

class _HomeScreenEventState extends State<HomeScreenEvent> {
  late ScrollController _scrollController;
  late List<String> locations;
  late List<EventTypeModel> eventTypes;
  late List<PreEventsModel> preEvents = [];
  late String _selectedLocation;
  late String _userName;
  double _savedScrollPosition = 0.0; // Save the scroll position
  final pageBucket = PageStorageBucket();

  Map<String, dynamic> filter = {
    'event_type_id': '0',
    'location': ['All'],
    'freemium': 'All',
    'visibility': 'All',
  };

  late EventBloc eventBloc;

  @override
  void initState() {
    super.initState();
    locations = getLocations();
    eventTypes = getEventTypes();
    _selectedLocation = "All";
    _userName = "Hemasundar";
    _scrollController = ScrollController();
    BlocProvider.of<EventBloc>(context).add(FetchData(init: true));
  }

  @override
  void didChangeDependencies() {
    print("didChangeDependencies");
    super.didChangeDependencies();
    // Restore the scroll position after rebuilding
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_savedScrollPosition);
    });
    eventBloc = context.read<EventBloc>();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        BlocProvider.of<EventBloc>(context).add(FetchData(init: false));
      }
    });

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(),
        body: Center(
          child: Container(
            width: 800,
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildGreetingSection(
                            MediaQuery.of(context).size.width),
                        const SizedBox(height: 16),
                        _buildSearchBar(MediaQuery.of(context).size.width),
                        const SizedBox(height: 16),
                        _buildEventTypes(screenHeight),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
                _buildPopularEventsList(screenHeight, screenWidth)
              ],
            ),
          ),
        ),
        backgroundColor: ColorPalette.backgroundColor,
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      backgroundColor: AppColors.white,
      elevation: 0,
      title: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primaryBlue, AppColors.lightBlue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            const SizedBox(width: 10),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'Skillz',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  TextSpan(
                    text: 'Me',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  TextSpan(
                    text: 'ntors',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EventPostScreen(),
                    ),
                  );
                },
                child: Row(
                  children: [
                    const Text(
                      "New Post",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'TimesNewRoman',
                      ),
                    ),
                    const SizedBox(width: 5),
                    const HugeIcon(
                        icon: HugeIcons.strokeRoundedPlusSignSquare,
                        color: Colors.white),
                  ],
                )),
            const SizedBox(width: 5),
          ],
        ),
      ),
      iconTheme: const IconThemeData(
        color: AppColors.black,
      ),
    );
  }

  Widget _buildGreetingSection(double screenWidth) {
    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Hello, $_userName!",
              style: TextStyle(
                color: ColorPalette.textColor,
                fontWeight: FontWeight.w700,
                fontSize: 18,
                fontFamily: 'TimesNewRoman',
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "Let's explore what's happening nearby",
              style: TextStyle(
                color: ColorPalette.textColor,
                fontSize: 18,
                fontFamily: 'TimesNewRoman',
              ),
            ),
          ],
        ),
        const Spacer(),
      ],
    );
  }

  Widget _buildSearchBar(double screenWidth) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.grey, width: 2),
      ),
      child: Row(
        children: [
          const Icon(
            HugeIcons.strokeRoundedSearch02,
            color: ColorPalette.primaryColor,
          ),
          SizedBox(width: screenWidth * 0.02),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search for events",
                border: InputBorder.none,
              ),
              style: const TextStyle(fontFamily: 'TimesNewRoman'),
              onChanged: (query) {
                context.read<EventBloc>().add(SearchQueryChanged(query));
              },
            ),
          ),
          IconButton(
            icon: const Icon(
              HugeIcons.strokeRoundedFilterHorizontal,
              color: ColorPalette.primaryColor,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return EventFilterComponent(
                    onApplyFilters: (visibility, type, locations) {
                      print('From Origin visibility: $visibility');
                      print('From Origin type: $type');
                      print('From Origin locations: $locations');
                      eventBloc.add(AddFilter('visibility', visibility));
                      eventBloc.add(AddFilter('free', type));
                      // eventBloc.add(AddFilter('location', locations));
                      Future.delayed(const Duration(milliseconds: 500), () {
                        eventBloc.add(FetchData(init: true));
                      });
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEventTypes(double screenHeight) {
    return SizedBox(
      height: 0.07 * screenHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: eventTypes.map((eventType) {
          return GestureDetector(
            onTap: () {
              if (eventType.eventType == "Hackathon") {
                context.read<EventBloc>().add(AddFilter('event_type_id', '1'));
              } else if (eventType.eventType == "Academic") {
                context.read<EventBloc>().add(AddFilter('event_type_id', '2'));
              } else if (eventType.eventType == "Sports") {
                context.read<EventBloc>().add(AddFilter('event_type_id', '3'));
              } else {
                context.read<EventBloc>().add(AddFilter('event_type_id', '0'));
              }
              context.read<EventBloc>().add(SelectEvent(eventType.eventType));
              //After some delay the fetch data event is called
              Future.delayed(const Duration(milliseconds: 500), () {
                context.read<EventBloc>().add(FetchData(init: true));
              });
            },
            child: EventTypeComponent(
              eventType: eventType.eventType,
              icon: eventType.icon,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPopularEventsList(double screenHeight, double screenWidth) {
    return BlocBuilder<EventBloc, EventBlocStates>(
      builder: (context, state) {
        if (state is FetchDataLoadingState && state.isInitial) {
          return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is FetchDataErrorState) {
          return const SliverToBoxAdapter(
            child: Center(child: Text("Error loading events")),
          );
        }

        if (state is FetchDataState) {
          if (state.init) {
            preEvents.clear();
            preEvents.addAll(state.events);
          } else {
            preEvents.addAll(state.events);
          }
        }

        bool isLoadingMore = state is FetchDataLoadingState && !state.isInitial;

        return PageStorage(
          bucket: pageBucket,
          child: SliverList(
            key: const PageStorageKey<String>("popular_events_list"),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index < preEvents.length) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EventDetails(id: preEvents[index].id),
                          ),
                        );
                      },
                      child: PopularEventTile(event: preEvents[index]),
                    ),
                  );
                }

                // Show bottom loader
                if (isLoadingMore) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (state is FetchDataLoadingReachedEndState) {
                  // Show "No more events to load" message
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: Text("No more events to load")),
                  );
                }
              },
              childCount:
                  preEvents.length + 1, // Add one extra item for loader/message
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    // Dispose of the scroll controller to avoid memory leaks
    _scrollController.dispose();
    super.dispose();
  }
}
