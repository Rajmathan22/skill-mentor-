import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';
import 'package:skillzmentors/Screens/event_screen/events_model.dart';
import 'package:skillzmentors/config/Colors/colors.dart';

class PopularEventTile extends StatefulWidget {
  final PreEventsModel event;

  const PopularEventTile({
    super.key,
    required this.event,
  });

  @override
  State<PopularEventTile> createState() => _PopularEventTileState();
}

class _PopularEventTileState extends State<PopularEventTile> {
  late DateTime parsedDate;
  late String day;
  late String month;

  /// Parses and formats the event date
  void getFormattedDate() {
    try {
      final cleanedDateString = widget.event.eventStartDate.trim();

      if (cleanedDateString.isEmpty) {
        throw FormatException('Empty date string');
      }

      parsedDate = DateFormat("dd MMMM yyyy").parse(cleanedDateString);

      day = DateFormat("d").format(parsedDate);
      month = DateFormat("MMM").format(parsedDate);
    } catch (e) {
      debugPrint(
          'Error parsing date: $e. Input: ${widget.event.eventStartDate}');
      parsedDate = DateTime.now();
      day = DateFormat("d").format(parsedDate);
      month = DateFormat("MMM").format(parsedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    getFormattedDate();

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Positioned(
                  child: Container(
                    height: screenWidth > 800 ? screenHeight * 0.5 : screenHeight * 0.3,
                    width: double.infinity,
                    foregroundDecoration: RotatedCornerDecoration.withColor(
                      color: widget.event.price == "₹0.00"
                          ? Colors.greenAccent
                          : Colors.redAccent,
                      spanBaselineShift: 4,
                      badgeSize: const Size(50, 50),
                      badgeCornerRadius: const Radius.circular(30),
                      badgePosition: BadgePosition.topStart,
                      textSpan: TextSpan(
                        text: widget.event.price == "₹0.00" ? "Free" : "Paid",
                        style: TextStyle(
                          color: widget.event.price == "₹0.00"
                              ? ColorPalette.textColor
                              : ColorPalette.secondaryTextColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          fontFamily: 'TimesNewRoman',
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: widget.event.eventPoster.isNotEmpty
                          ? DecorationImage(
                        image: NetworkImage(widget.event.eventPoster),
                        opacity: 0.9,
                        fit: BoxFit.cover,
                        onError: (exception, stackTrace) {
                          debugPrint("Failed to load image: $exception");
                        },
                      )
                          : null,
                    ),
                  )),
              Positioned(
                top: 10,
                right: 10,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: ColorPalette.backgroundColor.withOpacity(0.7),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          day,
                          style: TextStyle(
                            color: ColorPalette.textColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'TimesNewRoman',
                          ),
                        ),
                        Text(
                          month,
                          style: TextStyle(
                            color: ColorPalette.textColor,
                            fontSize: 18,
                            fontFamily: 'TimesNewRoman',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: ColorPalette.backgroundColor.withOpacity(0.8),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.event.eventType,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorPalette.textColor,
                            fontSize: 18,
                            fontFamily: 'TimesNewRoman',
                          ),
                        ),
                        Text(
                          widget.event.eventName,
                          style: TextStyle(
                            color: ColorPalette.textColor,
                            fontSize: 18,
                            fontFamily: 'TimesNewRoman',
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Icon(
                              HugeIcons.strokeRoundedUniversity,
                              color: ColorPalette.textColor,
                              size: 20,
                            ),
                            const SizedBox(width: 5),
                            ShrinkTextWidget(
                              fontSize: 18,
                              text: widget.event.collegeName,
                              maxCharacters: 10,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              HugeIcons.strokeRoundedLocation01,
                              color: ColorPalette.textColor,
                              size: 20,
                            ),
                            const SizedBox(width: 5),
                            ShrinkTextWidget(
                              fontSize: 18,
                              text: widget.event.collegeAddress,
                              maxCharacters: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

class ShrinkTextWidget extends StatelessWidget {
  final String text;
  final int maxCharacters;
  final double fontSize;

  const ShrinkTextWidget({
    Key? key,
    required this.text,
    required this.maxCharacters,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final truncatedName = text.length > maxCharacters
        ? '${text.substring(0, maxCharacters)}...'
        : text;

    return Text(
      truncatedName,
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: 'TimesNewRoman',
      ),
      textAlign: TextAlign.center,
    );
  }
}
