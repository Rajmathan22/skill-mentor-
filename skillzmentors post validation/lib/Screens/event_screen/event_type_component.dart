import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:skillzmentors/ViewModel/event_bloc/event_bloc.dart';
import 'package:skillzmentors/ViewModel/event_bloc/event_bloc_states.dart';
import 'package:skillzmentors/config/Colors/colors.dart';

class EventTypeComponent extends StatelessWidget {
  final String eventType;
  final HugeIcon? icon;

  const EventTypeComponent({super.key, required this.eventType, this.icon});

  @override
  Widget build(BuildContext context) {
    String selectedEvent = 'All Event';

    return BlocBuilder<EventBloc, EventBlocStates>(
      builder: (context, state) {
        // Determine selected event from the state
        if (state is EventTypeState) {
          selectedEvent = state.selectedEvent;
        }

        bool isSelected = selectedEvent == eventType;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 50,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: isSelected ? ColorPalette.buttonColor : Colors.grey[400],
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(2),
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white,
                  child: icon ?? const Icon(Icons.event, color: ColorPalette.textColor),
                ),
              ),
              AnimatedOpacity(
                opacity: isSelected ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: isSelected
                    ? Text(
                  eventType,
                  style: TextStyle(
                    color: isSelected
                        ? ColorPalette.secondaryTextColor
                        : ColorPalette.textColor,
                    fontSize: 14,
                    fontFamily: 'TimesNewRoman',
                  ),
                )
                    : const SizedBox.shrink(),
              ),
              isSelected ? SizedBox(width: 5) : const SizedBox.shrink(),
            ],
          ),
        );
      },
    );
  }
}
