import 'dart:convert';
import 'dart:io';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillzmentors/Screens/event_screen/events_model.dart';
import 'package:skillzmentors/ViewModel/event_bloc/event_bloc_events.dart';
import 'package:skillzmentors/ViewModel/event_bloc/event_bloc_states.dart';
import 'package:http/http.dart' as http;

const String token = '2|fsZUC2wMQ7p5lnSjEU8c4AD84t6qvx17ySEjbS1U7fd52875';
String baseurl = 'https://skillzmentors.vercel.app/api/api/events/';
String nexturl = '';

String selectedEvent = "All Event";
String searchQuery = "";

String free = '';
String visibility = '';
List<String> locations = [];
String event_type_id = '0';

String endParam = "";

const Map<String, String> defaultHeaders = {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer $token',
};

class EventBloc extends Bloc<EventBlocEvents, EventBlocStates> {
  EventBloc() : super(FetchDataState()) {
    on<FetchData>(_handleFetchData);
    on<SelectEvent>(_handleSelectEvent);
    on<SearchQueryChanged>(_handleSearchQueryChanged);
    on<FetchFilterEvent>(_handleFetchFilter);
    on<FetchEvent>(_handleFetchEvent);
    on<PostEvent>(_handlePostEvent);
    on<AddFilter>(_addFilter);
  }

  Future<void> _handleFetchEvent(
      FetchEvent event, Emitter<EventBlocStates> emit) async {
    emit(FetchDataLoadingState(isLoading: true, isInitial: true));
    try {
      String id = event.eventId;
      final response =
          await http.get(Uri.parse(baseurl + id), headers: defaultHeaders);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body) as Map<String, dynamic>;
        final EventsModel event = EventsModel.fromJson(decodedJson);
        print(event.eventName);
        emit(FetchEventState(events: event));
      } else {
        log('Failed to fetch events (Status code: ${response.statusCode})');
        emit(FetchEventErrorState(
            errorMessage:
                'Failed to fetch events (Status code: ${response.statusCode})'));
      }
    } catch (error) {
      log('Failed to fetch events (Error: $error)');
      emit(FetchEventErrorState(errorMessage: error.toString()));
    }
  }

  Future<void> _handlePostEvent(
      PostEvent event, Emitter<EventBlocStates> emit) async {
    emit(PostEventLoadingState(isLoading: true, isInitial: true));
    try {
      PostEventModel postEvent = event.event;
      //Body
      Map<String, String> body = {
        'event_name': postEvent.event_name,
        'event_type_id': postEvent.event_type_id,
        'visibility': postEvent.visibility,
        'topics': postEvent.topics,
        'eligibility': postEvent.eligibility,
        'registration_start_date': postEvent.registration_start_date,
        'registration_end_date': postEvent.registration_end_date,
        'event_start_date': postEvent.event_start_date,
        'event_end_date': postEvent.event_end_date,
        'about_this_event': postEvent.about_this_event,
        'event_description': postEvent.event_description,
        'venue': postEvent.venue,
        'registration_fee': postEvent.registration_fee
      };
      //Headers
      const Map<String, String> headers = {
        'Authorization': 'Bearer $token',
      };

      final response =
          await http.post(Uri.parse(baseurl), headers: headers, body: body);
      if (response.statusCode == 201) {
        final jsonData = response.body;
        final data = jsonDecode(jsonData);
        log('Posted events successfully: ${data['message']} and ID: ${data['event']['id']}');
        emit(PostEventState());
      } else {
        log('Failed to Post events (Status code: ${response.statusCode})');
        emit(PostEventErrorState(
            errorMessage:
                'Failed to Post Events (Status code: ${response.statusCode})'));
      }
    } catch (error) {
      log('Failed to Post events (Error: $error)');
      emit(PostEventErrorState(errorMessage: error.toString()));
    }
  }

  Future<void> _addFilter(AddFilter event, Emitter<EventBlocStates> emit) async {
    final key = event.key;
    final value = event.value;
    endParam = ''; // Reset endParam to ensure a fresh query string.

    // Update the filter values based on the key
    if (key == 'free') {
      free = value;
    } else if (key == 'visibility') {
      visibility = value;
    } else if (key == 'location') {
      locations.add(value);
    } else if (key == 'event_type_id') {
      event_type_id = value;
    }

    // Handle case when event_type_id is '0' (no filter) or an empty string
    if (event_type_id == '0') {
      event_type_id = '';
    }

    // Ensure locations has a default empty value if it’s empty
    if (locations.isEmpty) {
      locations = [''];
    }

    // Assign the filter parameters
    if (free == 'Free') {
      free = 'free=true';
    } else if (free == 'Paid') {
      free = 'free=false';
    } else {
      free = '';
    }

    if (visibility == 'Public') {
      visibility = 'public';
    } else if (visibility == 'Private') {
      visibility = 'private';
    } else {
      visibility = '';
    }

    // Build the query string for endParam
    if (event_type_id.isNotEmpty) {
      endParam += '&event_type_id=$event_type_id';
    }

    if (locations.isNotEmpty && locations[0].isNotEmpty) {
      endParam += '&location=${locations.join(',')}';
    }

    if (free.isNotEmpty) {
      endParam += '&$free';
    }

    if (visibility.isNotEmpty) {
      endParam += '&visibility=$visibility';
    }

    // Emit updated filter parameters
    print('locations: $locations');
    print('free: $free');
    print('visibility: $visibility');
    print('event_type_id: $event_type_id');
    print('endParam: $endParam');
  }

  Future<void> _handleFetchData(
      FetchData event, Emitter<EventBlocStates> emit) async {
    emit(FetchDataLoadingState(isLoading: true, isInitial: event.init));
    final bool init = event.init;
    String url;
    if (init) {
      url = baseurl + '?page=1';
    } else if (nexturl == '') {
      print('Reached end');
      emit(FetchDataLoadingReachedEndState());
      return;
    } else {
      url = nexturl.replaceFirst('http', 'https');
    }
    try {
      print("URL: " + url + endParam);
      final response =
          await http.get(Uri.parse(url + endParam), headers: defaultHeaders);
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body) as Map<String, dynamic>;
        final List<PreEventsModel> fetchedEvents = (decodedJson['data'] as List)
            .map((e) => PreEventsModel.fromJson(e))
            .toList();
        nexturl = decodedJson['next_page_url'] ?? '';
        log('nexturl: $nexturl');
        emit(FetchDataState(events: fetchedEvents, init: init));
      } else {
        log('Failed to fetch events (Status code: ${response.statusCode})');
        emit(FetchDataErrorState(
            errorMessage:
                'Failed to fetch events (Status code: ${response.statusCode})'));
      }
    } catch (error) {
      log('Failed to fetch events (Error: $error)');
      emit(FetchDataErrorState(errorMessage: error.toString()));
    }
  }

  void _handleFetchFilter(FetchFilterEvent event, Emitter<EventBlocStates> emit) async {
    try {
      final response = await http.get(
        Uri.parse('https://skillzmentors.vercel.app/api/api/events/filter'),
        headers: defaultHeaders,
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        // Extract the cities from the locations list and remove duplicates
        List<dynamic> rawLocations = data['locations'];
        List<String> uniqueCities = rawLocations
            .map((location) => location['city'] as String)
            .toSet() // Remove duplicates
            .toList();

        emit(FetchFilterState(locations: uniqueCities));
      } else {
        log('Failed to fetch filters: ${response.statusCode}');
        emit(FetchFilterErrorState(errorMessage: 'Failed to fetch filters'));
      }
    } catch (error) {
      log('Failed to fetch filters: $error');
      emit(FetchFilterErrorState(errorMessage: error.toString()));
    }
  }


  Future<void> _handleSelectEvent(SelectEvent event, Emitter<EventBlocStates> emit) async {
    // Update the selected event state
    selectedEvent = event.eventType;
    emit(EventTypeState(selectedEvent: selectedEvent));
  }


  Future<void> _handleSearchQueryChanged(
      SearchQueryChanged event, Emitter<EventBlocStates> emit) async {
    searchQuery = event.query;
    add(FetchData(
        init: true)); // Trigger a new fetch with the updated search query
  }
}

class EventPostBloc extends Bloc<EventPostEvent, EventPostState> {
  EventPostBloc() : super(EventPostState()) {
    on<UpdateEventName>((event, emit) {
      emit(state.copyWith(eventName: event.eventName));
    });

    on<UpdateEventType>((event, emit) {
      emit(state.copyWith(eventType: event.eventType));
    });

    on<PickEventDate>((event, emit) {
      emit(state.copyWith(eventDate: event.eventDate));
    });

    on<PickStartTime>((event, emit) {
      emit(state.copyWith(eventStartTime: event.startTime));
    });

    on<PickEndTime>((event, emit) {
      emit(state.copyWith(eventEndTime: event.endTime));
    });

    on<PickImages>((event, emit) {
      emit(state.copyWith(selectedImages: event.images));
    });

    on<RemoveImage>((event, emit) {
      final updatedImages = List<File>.from(state.selectedImages)
        ..removeAt(event.index);
      emit(state.copyWith(selectedImages: updatedImages));
    });
  }
}
