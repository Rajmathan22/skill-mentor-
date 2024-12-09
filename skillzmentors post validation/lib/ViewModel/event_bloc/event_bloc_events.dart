import 'dart:io';
import 'package:flutter/material.dart';
import 'package:skillzmentors/Screens/event_screen/events_model.dart';

abstract class EventBlocEvents {}

class FetchData extends EventBlocEvents {
  final bool init;
  FetchData({this.init = false});
}

class FetchEvent extends EventBlocEvents {
  final String eventId;
  FetchEvent(this.eventId);
}

class PostEvent extends EventBlocEvents {
  final PostEventModel event;
  PostEvent(this.event);
}

class AddFilter extends EventBlocEvents {
  final String key;
  final dynamic value;
  AddFilter(this.key, this.value);
}

class FetchFilterEvent extends EventBlocEvents { }

class SelectEvent extends EventBlocEvents {
  final String eventType;
  SelectEvent(this.eventType);
}

class SelectLocation extends EventBlocEvents {
  final String location;
  SelectLocation(this.location);
}

class SearchQueryChanged extends EventBlocEvents {
  final String query;
  SearchQueryChanged(this.query);
}

//-----------------Event Post Event-------------------

abstract class EventPostEvent {}

class UpdateEventName extends EventPostEvent {
  final String eventName;
  UpdateEventName(this.eventName);
}

class UpdateEventType extends EventPostEvent {
  final String eventType;
  UpdateEventType(this.eventType);
}

class PickEventDate extends EventPostEvent {
  final DateTime? eventDate;
  PickEventDate(this.eventDate);
}

class PickStartTime extends EventPostEvent {
  final TimeOfDay startTime;
  PickStartTime(this.startTime);
}

class PickEndTime extends EventPostEvent {
  final TimeOfDay endTime;
  PickEndTime(this.endTime);
}

class PickImages extends EventPostEvent {
  final List<File> images;
  PickImages(this.images);
}

class RemoveImage extends EventPostEvent {
  final int index;
  RemoveImage(this.index);
}
