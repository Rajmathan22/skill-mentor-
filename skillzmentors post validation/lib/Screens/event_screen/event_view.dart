import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:skillzmentors/Screens/event_screen/events_model.dart';
import 'package:skillzmentors/ViewModel/event_bloc/event_bloc.dart';
import 'package:skillzmentors/ViewModel/event_bloc/event_bloc_events.dart';
import 'package:skillzmentors/ViewModel/event_bloc/event_bloc_states.dart';
import 'package:skillzmentors/config/Colors/colors.dart';
import 'package:skillzmentors/config/Theme/text_theme.dart';
import 'package:skillzmentors/config/string/string_test.dart';
import 'event_ticket.dart';

import 'package:flutter/material.dart';

class _EventDetailsState extends State<EventDetails> {
  int _currentIndex = 0; // Track the current active image in the carousel
  late EventsModel event;
  late DateTime parsedStartDate;
  late DateTime parsedEndDate;
  late String startDay;
  late String startMonth;
  late String endDay;
  late String endMonth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<EventBloc>(context).add(FetchEvent(widget.id));
  }

  void getFormattedDate() {
    // Function to remove day suffixes from date strings
    String preprocessDate(String date) {
      return date.replaceAllMapped(
        RegExp(r'(\d+)(st|nd|rd|th)'), // Match numbers followed by suffixes
        (match) => match.group(1)!, // Keep only the numeric part
      );
    }

    // Preprocess the start and end dates
    String cleanedStartDate = preprocessDate(event.eventStartDate);
    String cleanedEndDate = preprocessDate(event.eventEndDate);

    // Parse the cleaned date strings
    parsedStartDate = DateFormat("d MMMM yyyy").parse(cleanedStartDate);
    startDay = DateFormat("d").format(parsedStartDate);
    startMonth = DateFormat("MMM").format(parsedStartDate);

    parsedEndDate = DateFormat("d MMMM yyyy").parse(cleanedEndDate);
    endDay = DateFormat("d").format(parsedEndDate);
    endMonth = DateFormat("MMM").format(parsedEndDate);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<EventBloc, EventBlocStates>(builder: (context, state) {
      if (state is FetchEventErrorState) {
        return Scaffold(
          body: Center(
            child: Text(state.errorMessage),
          ),
        );
      }

      if (state is FetchDataLoadingState) {}

      if (state is FetchEventState) {
        event = state.events;
        getFormattedDate();
        return Scaffold(
          backgroundColor: ColorPalette.backgroundColor,
          body: Center(
            child: Container(
              width: screenWidth > 800 ? screenWidth * 0.5 : 800,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top half with carousel and blurred background
                    Stack(
                      children: [
                        Container(
                          height: screenHeight * 0.5,
                          // Limit to half of the screen height
                          width: screenWidth,
                          decoration: const BoxDecoration(
                            boxShadow: null,
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 40, // Padding for status bar
                                left: 0,
                                right: 0,
                                child: Column(
                                  children: [
                                    // Top navigation row
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () => Navigator.pop(context),
                                            child: const CircleAvatar(
                                              radius: 25,
                                              backgroundColor: Color(0xD38C8C8C),
                                              child: HugeIcon(
                                                icon: HugeIcons
                                                    .strokeRoundedArrowLeft01,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          event.eventType,
                                          style: MyTextTheme.headline,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () => Navigator.pop(context),
                                            child: const CircleAvatar(
                                              radius: 25,
                                              backgroundColor: Color(0xD38C8C8C),
                                              child: HugeIcon(
                                                icon:
                                                    HugeIcons.strokeRoundedShare08,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Container(
                                      width: double.infinity, // Makes it take full width of the screen
                                      height: screenHeight * 0.3, // Adjust the height proportionally to the screen
                                      child: CarouselSlider(
                                        items: event.eventImages.map((imagePath) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return ClipRRect(
                                                borderRadius: BorderRadius.circular(8.0), // Rounded corners (optional)
                                                child: Image.network(
                                                  imagePath,
                                                  fit: BoxFit.contain, // Ensures the image is fully visible
                                                  width: double.infinity, // Adjust to container's width
                                                ),
                                              );
                                            },
                                          );
                                        }).toList(),
                                        options: CarouselOptions(
                                          height: screenHeight * 0.3, // Consistent height for the carousel
                                          autoPlay: true,
                                          viewportFraction: 1.0, // Ensures each item occupies full width
                                          enlargeCenterPage: false, // Disable center item enlargement
                                          onPageChanged: (index, reason) {
                                            setState(() {
                                              _currentIndex = index;
                                            });
                                          },
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ), // Bottom details section
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              // Add your PDF download logic here
                            },
                            icon: const HugeIcon(
                                icon: HugeIcons.strokeRoundedDownloadCircle02,
                                color: Color(0xffffffff)),
                            label: Text(
                              "Download Brochure",
                              style: MyTextTheme.normal.copyWith(
                                color: Color(0xffffffff),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: event.price == "₹0.00"
                                  ? Colors.green
                                  : Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              event.price == "₹0.00" ? "Free" : event.price,
                              style: MyTextTheme.headline.copyWith(
                                  color: event.price == "₹0.00"
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20,left: 20, right: 20),
                      child: Wrap(
                          spacing: 8.0, // Horizontal spacing
                          runSpacing: 4.0, // Vertical spacing
                          children: [
                          Text(event.eventName, style: MyTextTheme.headline)
                        ]
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Wrap(
                        spacing: 8.0, // Horizontal spacing
                        runSpacing: 4.0,
                          children: [ Text(event.topics,
                            style: MyTextTheme.body
                                .copyWith(color: ColorPalette.textColor)),
                      ]
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                      child: Row(
                        children: [
                          const Icon(
                            HugeIcons.strokeRoundedLocation01,
                            color: ColorPalette.textColor,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                text: "Venue: ",
                                style: MyTextTheme.subheading,
                                children: [
                                  TextSpan(
                                      text: event.venue, style: MyTextTheme.body),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                      child: Row(
                        children: [
                          const Icon(
                            HugeIcons.strokeRoundedUniversity,
                            color: ColorPalette.textColor,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                text: "College: ",
                                style: MyTextTheme.subheading,
                                children: [
                                  TextSpan(
                                      text: event.collegeName,
                                      style: MyTextTheme.body),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Date(
                        startDay: startDay,
                        startMonth: startMonth,
                        endDay: endDay,
                        endMonth: endMonth,
                        startTime: event.eventStartTime,
                        endTime: event.eventEndTime,
                        isSameDay: event.eventStartDate == event.eventEndDate,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                      child: Row(
                        children: [
                          const Icon(
                            HugeIcons.strokeRoundedCalendar01,
                            color: ColorPalette.textColor,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          RichText(
                            text: TextSpan(
                              text: "Start Date: ",
                              style: MyTextTheme.subheading,
                              children: [
                                TextSpan(
                                  text: event.registrationStartDate,
                                  style: MyTextTheme.body,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                      child: Row(
                        children: [
                          const Icon(
                            HugeIcons.strokeRoundedCalendar01,
                            color: ColorPalette.textColor,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          RichText(
                            text: TextSpan(
                              text: "End Date: ",
                              style: MyTextTheme.subheading,
                              children: [
                                TextSpan(
                                  text: event.registrationEndDate,
                                  style: MyTextTheme.body,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                      child: Row(
                        children: [
                          const Icon(
                            HugeIcons.strokeRoundedCheckmarkBadge04,
                            color: ColorPalette.textColor,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                text: "Eligibility: ",
                                style: MyTextTheme.subheading,
                                children: [
                                  TextSpan(
                                    text: event.eligibility,
                                    style: MyTextTheme.body,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                      child: RichText(
                        text: TextSpan(
                          text: "About: ",
                          style: MyTextTheme.subheading,
                          children: [
                            TextSpan(
                              text: event.aboutThisEvent,
                              style: MyTextTheme.body,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                      child: RichText(
                        text: TextSpan(
                          text: "Event Description: ",
                          style: MyTextTheme.subheading,
                          children: [
                            TextSpan(
                              text: event.eventDescription,
                              style: MyTextTheme.body,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
            decoration: BoxDecoration(
              boxShadow: [
                //The shadow indicates the above is a list view and the shadow will be on the top layer of this container like a elveation
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 20,
                  blurStyle: BlurStyle.outer,
                  offset: const Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => TicketScreen(eventsList: event)));
                    },
                    icon: const HugeIcon(
                        icon: HugeIcons.strokeRoundedFavourite,
                        color: Color(0xffffffff)),
                    label: Text(
                      "Like",
                      style: MyTextTheme.body.copyWith(
                        color: Color(0xffffffff),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => TicketScreen(eventsList: event)));
                    },
                    icon: const HugeIcon(
                        icon: HugeIcons.strokeRoundedTicket02,
                        color: Color(0xffffffff)),
                    label: Text(
                      "Get a Ticket",
                      style: MyTextTheme.body.copyWith(
                        color: Color(0xffffffff),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorPalette.accentColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }
}

class EventDetails extends StatefulWidget {
  final String id;

  const EventDetails({super.key, required this.id});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class Date extends StatelessWidget {
  String startDay;
  String startMonth;
  String endDay;
  String endMonth;
  String startTime;
  String endTime;
  bool isSameDay;

  Date(
      {super.key,
      required this.isSameDay,
      required this.endDay,
      required this.startDay,
      required this.startMonth,
      required this.endMonth,
      required this.startTime,
      required this.endTime});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Card(
          elevation: 5,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(startMonth,
                      style: MyTextTheme.subheading
                          .copyWith(fontWeight: FontWeight.bold)),
                  Text(startDay, style: MyTextTheme.subheading),
                ],
              ),
              const VerticalDivider(
                color: Colors.black,
                thickness: 1,
                width: 2,
                indent: 10,
                endIndent: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: !isSameDay
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    "Event Timings",
                    style: MyTextTheme.headline,
                  ),
                  Row(
                    children: [
                      const Icon(HugeIcons.strokeRoundedClock01, size: 20),
                      SizedBox(width: 2),
                      Text(startTime,
                          style: MyTextTheme.normal),
                      const Text(" - ",
                          style: MyTextTheme.normal),
                      const Icon(HugeIcons.strokeRoundedClock01, size: 20),
                      SizedBox(width: 2),
                      Text(endTime,
                          style: MyTextTheme.normal),
                    ],
                  )
                ],
              ),
              Visibility(
                visible: !isSameDay,
                child: const VerticalDivider(
                  color: Colors.black,
                  thickness: 1,
                  width: 2,
                  indent: 10,
                  endIndent: 10,
                ),
              ),
              Visibility(
                visible: !isSameDay,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(endMonth,
                        style: MyTextTheme.subheading
                            .copyWith(fontWeight: FontWeight.bold)),
                    Text(endDay,
                        style: MyTextTheme.subheading),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
