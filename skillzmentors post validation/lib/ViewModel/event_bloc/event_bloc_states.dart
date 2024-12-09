import 'dart:io';
import 'package:flutter/material.dart';
import 'package:skillzmentors/Screens/event_screen/events_model.dart';

abstract class EventBlocStates {}

class FetchFilterState extends EventBlocStates {
  final List<String> locations;
  FetchFilterState({required this.locations});
}

class FetchFilterErrorState extends EventBlocStates {
  final String errorMessage;

  FetchFilterErrorState({this.errorMessage = ''});

  FetchFilterErrorState copyWith({String? errorMessage}) {
    return FetchFilterErrorState(errorMessage: errorMessage ?? this.errorMessage);
  }
}

class EventTypeState extends EventBlocStates {
  final String selectedEvent;
  EventTypeState({this.selectedEvent = 'All Event'});

  EventTypeState copyWith({String? selectedEvent}) {
    return EventTypeState(selectedEvent: selectedEvent ?? this.selectedEvent);
  }
}

class EventLocationState extends EventBlocStates {
  final String selectedLocation;

  EventLocationState({this.selectedLocation = 'All'});

  EventLocationState copyWith({String? selectedLocation}) {
    return EventLocationState(selectedLocation: selectedLocation ?? this.selectedLocation);
  }
}

class EventSearchState extends EventBlocStates {
  final String searchQuery;

  EventSearchState({this.searchQuery = ''});

  EventSearchState copyWith({String? searchQuery}) {
    return EventSearchState(searchQuery: searchQuery ?? this.searchQuery);
  }
}

//--------------------------Add Filter State---------------------

class AddFiltersUpdatedState extends EventBlocStates {
  final String endParam;

  AddFiltersUpdatedState({required this.endParam});
}

//--------------------------Fetch Event Data States---------------------

class FetchDataState extends EventBlocStates {
  final List<PreEventsModel> events;
  final bool init;
  FetchDataState({this.events = const [],this.init = false});

  FetchDataState copyWith({List<PreEventsModel>? events, bool? init}) {
    return FetchDataState(events: events ?? this.events, init: init ?? this.init);
  }
}

class FetchDataLoadingState extends EventBlocStates {
  final bool isLoading;
  final bool isInitial;

  FetchDataLoadingState({this.isLoading = false,this.isInitial = false});

  FetchDataLoadingState copyWith({bool? isLoading}) {
    return FetchDataLoadingState(isLoading: isLoading ?? this.isLoading);
  }
}

class FetchDataLoadingReachedEndState extends EventBlocStates {
  final bool isReachEnd;
  FetchDataLoadingReachedEndState({this.isReachEnd = true});

  FetchDataLoadingReachedEndState copyWith({bool? isLoading}) {
    return FetchDataLoadingReachedEndState(isReachEnd: isLoading ?? this.isReachEnd);
  }
}

class FetchDataErrorState extends EventBlocStates {
  final String errorMessage;

  FetchDataErrorState({this.errorMessage = ''});

  FetchDataErrorState copyWith({String? errorMessage}) {
    return FetchDataErrorState(errorMessage: errorMessage ?? this.errorMessage);
  }
}

//--------------------Fetch Event States--------------------------------

class FetchEventState extends EventBlocStates {
  final EventsModel events;
  FetchEventState({required this.events});

  FetchEventState copyWith({EventsModel? events}) {
    return FetchEventState(events: events ?? this.events);
  }
}

class FetchEventLoadingState extends EventBlocStates {
  final bool isLoading;
  final bool isInitial;

  FetchEventLoadingState({this.isLoading = false, this.isInitial = false});

  FetchEventLoadingState copyWith({bool? isLoading}) {
    return FetchEventLoadingState(isLoading: isLoading ?? this.isLoading);
  }
}

class FetchEventErrorState extends EventBlocStates {
  final String errorMessage;

  FetchEventErrorState({this.errorMessage = ''});

  FetchEventErrorState copyWith({String? errorMessage}) {
    return FetchEventErrorState(errorMessage: errorMessage ?? this.errorMessage);
  }
}

//--------------------Post Event States--------------------------------

class PostEventState extends EventBlocStates {}

class PostEventLoadingState extends EventBlocStates {
  final bool isLoading;
  final bool isInitial;

  PostEventLoadingState({this.isLoading = false, this.isInitial = false});

  PostEventLoadingState copyWith({bool? isLoading}) {
    return PostEventLoadingState(isLoading: isLoading ?? this.isLoading);
  }
}

class PostEventErrorState extends EventBlocStates {
  final String errorMessage;

  PostEventErrorState({this.errorMessage = ''});

  PostEventErrorState copyWith({String? errorMessage}) {
    return PostEventErrorState(errorMessage: errorMessage ?? this.errorMessage);
  }
}

//--------------------Event Post States--------------------------------

class EventPostState {
  final String eventName;
  final String eventType;
  final DateTime? eventDate;
  final TimeOfDay eventStartTime;
  final TimeOfDay eventEndTime;
  final List<File> selectedImages;

  EventPostState({
    this.eventName = '',
    this.eventType = '',
    this.eventDate,
    this.eventStartTime = const TimeOfDay(hour: 0, minute: 0),
    this.eventEndTime = const TimeOfDay(hour: 0, minute: 0),
    this.selectedImages = const [],
  });

  EventPostState copyWith({
    String? eventName,
    String? eventType,
    DateTime? eventDate,
    TimeOfDay? eventStartTime,
    TimeOfDay? eventEndTime,
    List<File>? selectedImages,
  }) {
    return EventPostState(
      eventName: eventName ?? this.eventName,
      eventType: eventType ?? this.eventType,
      eventDate: eventDate ?? this.eventDate,
      eventStartTime: eventStartTime ?? this.eventStartTime,
      eventEndTime: eventEndTime ?? this.eventEndTime,
      selectedImages: selectedImages ?? this.selectedImages,
    );
  }
}
