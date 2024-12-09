import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillzmentors/ViewModel/event_bloc/event_bloc.dart';
import 'package:skillzmentors/ViewModel/event_bloc/event_bloc_states.dart';
import 'package:skillzmentors/config/Colors/colors.dart';

class LocationTile extends StatelessWidget {
  final String locationName;
  LocationTile({
    super.key,
    required this.locationName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventBloc, EventBlocStates>(
      bloc: EventBloc(),
      builder: (context,state) {
        final isSelected = EventLocationState().selectedLocation == locationName;
        return Container(
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: isSelected ? ColorPalette.accentColor : Colors.transparent,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: isSelected ? Colors.transparent : ColorPalette.primaryColor,
              width: 1.5,
            ),
          ),
          child: Center(
            child: Text(
              locationName,
              style: TextStyle(
                color: isSelected ? ColorPalette.secondaryTextColor : ColorPalette.textColor,
                fontWeight: FontWeight.w600,
                fontFamily: 'TimesNewRoman',
              ),
            ),
          ),
        );
      }
    );
  }
}
