import 'package:barcode/barcode.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:skillzmentors/Screens/event_screen/events_model.dart';
import 'package:skillzmentors/config/Colors/colors.dart';
import 'package:skillzmentors/config/Theme/text_theme.dart';
import 'package:skillzmentors/config/string/string_test.dart';

class TicketScreen extends StatefulWidget {
  EventsModel eventsList;

  TicketScreen({required this.eventsList});

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final path = Path()..cubicTo(0, 0, 0, 0, 0, 0);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: Center(
          child: Container(
            width: 400,
            child: Stack(
              children: [
                Positioned(
                  top: 10, // Padding for status bar
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
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
                                  icon: HugeIcons.strokeRoundedArrowLeft01,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "Ticket",
                            style: const TextStyle(
                              color: ColorPalette.textColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                                fontFamily: 'TimesNewRoman'
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: const CircleAvatar(
                                radius: 25,
                                backgroundColor: Color(0xD38C8C8C),
                                child: HugeIcon(
                                  icon: HugeIcons.strokeRoundedShare08,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 80,
                  left: 10,
                  right: 10,
                  child: Container(
                    height: 600,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color(0xFFE5E5E5),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SizedBox(
                            height: 200,
                            width: screenWidth,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
                              ),
                              child: Image.network(
                                widget.eventsList.eventPoster,
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                              ),
                            ),
                          ),
                        ),
      
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 300,
                  left: 30,
                  right: 30,
                  child: Container(
                    height: 210,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.eventsList.eventName,
                                style: MyTextTheme.headline
                              ),
                              Text(
                                widget.eventsList.eventStartDate,
                                  style: MyTextTheme.subheading
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              DottedDashedLine(
                                dashSpace: 5,
                                height: 0,
                                width: 260,
                                axis: Axis.horizontal,
                                dashColor: Colors.grey,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                  top: 10,
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Date",
                                            style: MyTextTheme.body.copyWith(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            "Time",
                                            style: MyTextTheme.body.copyWith(
                                          color: Colors.grey,
                                          ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(widget.eventsList.eventStartDate,style: MyTextTheme.body),
                                          Text(widget.eventsList.eventStartTime,style: MyTextTheme.body),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Venue",
                                            style: MyTextTheme.body.copyWith(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            "Seat",
                                            style: MyTextTheme.body.copyWith(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(widget.eventsList.venue , style: MyTextTheme.body),
                                          Text("No seat" , style: MyTextTheme.body),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 510,
                  left: 30,
                  right: 30,
                  child: ClipPath(
                    clipper: TicketClipper(),
                    child: Container(
                      height: 50,
                      color: Colors.white,
                      child: Center(
                        child: DottedDashedLine(
                          dashSpace: 5,
                          height: 0,
                          width: 260,
                          axis: Axis.horizontal,
                          dashColor: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 560,
                  left: 30,
                  right: 30,
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        )),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Center(
                          child: BarcodeWidget(
                        barcode: Barcode.code128(escapes: true),
                        data: "Hello World",
                        width: 300,
                        height: 50,
                        drawText: false,
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: ColorPalette.backgroundColor,
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Add your PDF download logic here
                  },
                  icon: const HugeIcon(
                      icon: HugeIcons.strokeRoundedDownload02,
                      color: Color(0xffffffff)),
                  label: const Text(
                    "Image",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Config.textSize
                      , 
                            fontFamily: 'TimesNewRoman'
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
              const SizedBox(width: 20),
              SizedBox(
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Add your PDF download logic here
                  },
                  icon: const HugeIcon(
                      icon: HugeIcons.strokeRoundedQrCode,
                      color: Color(0xdb1b1919)),
                  label: const Text(
                    "QR Code",
                    style: TextStyle(
                      color: ColorPalette.textColor,
                      fontSize: Config.textSize, 
                            fontFamily: 'TimesNewRoman'
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Start from top-left corner
    path.moveTo(0, 0);

    // Draw the top side
    path.lineTo(size.width, 0);

    // Draw the right arc cut
    path.arcToPoint(
      Offset(size.width, size.height),
      radius: Radius.circular(20),
      clockwise: false,
    );

    // Draw the bottom side
    path.lineTo(0, size.height);

    // Draw the left arc cut
    path.arcToPoint(
      Offset(0, 0),
      radius: Radius.circular(20),
      clockwise: false,
    );

    // Close the path
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
