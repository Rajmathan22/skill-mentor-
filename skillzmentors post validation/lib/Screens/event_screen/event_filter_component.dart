import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillzmentors/ViewModel/event_bloc/event_bloc.dart';
import 'package:skillzmentors/ViewModel/event_bloc/event_bloc_events.dart';
import 'package:skillzmentors/ViewModel/event_bloc/event_bloc_states.dart';

class EventFilterComponent extends StatefulWidget {
  final Function(String visibility, String type, List<String> locations)
      onApplyFilters;

  const EventFilterComponent({super.key, required this.onApplyFilters});

  @override
  State<EventFilterComponent> createState() => _EventFilterComponentState();
}

class _EventFilterComponentState extends State<EventFilterComponent> {
  String selectedVisibility = 'All';
  String selectedType = 'All';
  final List<String> selectedLocations = [];

  final List<String> visibilityOptions = ['All', 'Private', 'Public'];
  final List<String> typeOptions = ['All', 'Free', 'Paid'];

  //All The States in TamilNadu
  List<String> locationOptions = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<EventBloc>(context).add(FetchFilterEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventBloc, EventBlocStates>(builder: (context, state) {
      if (state is FetchFilterState) {
        locationOptions = state.locations;
        return AlertDialog(
          title: const Text('Filter Events'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Select Event Type'),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  children: <Widget>[
                    for (final type in typeOptions)
                      FilterChip(
                        label: Text(type),
                        selected: selectedType == type,
                        onSelected: (selected) {
                          setState(() {
                            selectedType = type;
                          });
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),
                const Text('Select Locations'),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  children: <Widget>[
                    for (final location in locationOptions)
                      FilterChip(
                        label: Text(location),
                        selected: selectedLocations.contains(location),
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              selectedLocations.add(location);
                            } else {
                              selectedLocations.remove(location);
                            }
                          });
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),
                const Text('Visibility'),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  children: <Widget>[
                    for (final visiblity in visibilityOptions)
                      FilterChip(
                        label: Text(visiblity),
                        selected: selectedVisibility == visiblity,
                        onSelected: (selected) {
                          setState(() {
                            selectedVisibility = visiblity;
                          });
                        },
                      ),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
            TextButton(
              onPressed: () {
                widget.onApplyFilters(
                    selectedVisibility, selectedType, selectedLocations);
                Navigator.of(context).pop();
              },
              child: const Text('Apply'),
            ),
          ],
        );
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
