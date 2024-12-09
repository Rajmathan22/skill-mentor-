import 'dart:io';

class EventsModel {
  final String id;
  final String eventName;
  final String eventType;
  final String topics;
  final String eligibility;
  final String registrationStartDate;
  final String registrationEndDate;
  final String eventStartDate;
  final String eventEndDate;
  final String eventStartTime;
  final String eventEndTime;
  final String aboutThisEvent;
  final String eventDescription;
  final String eventPoster;
  final List<String> eventImages;
  final String brochure;
  final String collegeName;
  final String venue;
  final String location;
  final String collegeAddress;
  final String price;

  EventsModel({
    required this.id,
    required this.eventName,
    required this.eventType,
    required this.topics,
    required this.eligibility,
    required this.registrationStartDate,
    required this.registrationEndDate,
    required this.eventStartDate,
    required this.eventEndDate,
    required this.eventStartTime,
    required this.eventEndTime,
    required this.aboutThisEvent,
    required this.eventDescription,
    required this.eventPoster,
    required this.eventImages,
    required this.brochure,
    required this.collegeName,
    required this.venue,
    required this.location,
    required this.collegeAddress,
    required this.price,
  });

  /// Factory method to parse JSON into EventsModel
  factory EventsModel.fromJson(Map<String, dynamic> json) {
    return EventsModel(
      id: json['id'].toString(), // Convert id to String if it's an int
      eventName: json['eventName'] as String,
      eventType: json['eventType'] as String,
      topics: json['topics'] as String,
      eligibility: json['eligibility'] as String,
      registrationStartDate: json['registrationStartDate'] as String,
      registrationEndDate: json['registrationEndDate'] as String,
      eventStartDate: json['eventStartDate'] as String,
      eventEndDate: json['eventEndDate'] as String,
      eventStartTime: json['eventStartTime'] as String,
      eventEndTime: json['eventEndTime'] as String,
      aboutThisEvent: json['aboutThisEvent'] as String,
      eventDescription: json['eventDescription'] as String,
      eventPoster: json['eventPoster'] as String,
      eventImages: (json['eventImages'] as List<dynamic>).map((e) => e as String).toList(),
      brochure: json['brochure'] as String,
      collegeName: json['collegeName'] as String,
      venue: json['venue'] as String,
      location: json['venue'] as String, // Assuming location is derived from 'venue'
      collegeAddress: json['collegeAddress'] as String,
      price: json['price'] as String,
    );
  }
}

class PreEventsModel {
  final String id;
  final String eventName;
  final String eventType;
  final String eventStartDate;
  final String eventPoster;
  final String collegeName;
  final String collegeAddress;
  final String price;

  PreEventsModel({
    required this.id,
    required this.eventName,
    required this.eventType,
    required this.eventStartDate,
    required this.eventPoster,
    required this.collegeName,
    required this.collegeAddress,
    required this.price,
  });

  /// Factory method to parse JSON into PreEventsModel
  factory PreEventsModel.fromJson(Map<String, dynamic> json) {
    return PreEventsModel(
      id: json['id'].toString(), // Convert id to String if it's an int
      eventName: json['eventName'] as String,
      eventType: json['eventType'] as String,
      eventStartDate: json['eventStartDate'] as String,
      eventPoster: json['eventPoster'] as String,
      collegeName: json['collegeName'] as String,
      collegeAddress: json['collegeAddress'] as String,
      price: json['price'] as String,
    );
  }
}

class PostEventModel {
  final String event_name;
  final String event_type_id;
  final String visibility;
  final String topics;
  final String eligibility;
  final String registration_start_date;
  final String registration_end_date;
  final String event_start_date;
  final String event_end_date;
  final String about_this_event;
  final String event_description;
  final String registration_fee;
  // final File event_poster;
  // final List<File> event_images;
  // final File brochure;
  final String venue;

  PostEventModel({
    required this.event_name,
    required this.event_type_id,
    required this.visibility,
    required this.topics,
    required this.eligibility,
    required this.registration_start_date,
    required this.registration_end_date,
    required this.event_start_date,
    required this.event_end_date,
    required this.about_this_event,
    required this.event_description,
    required this.registration_fee,
    // required this.event_poster,
    // required this.event_images,
    // required this.brochure,
    required this.venue,
  });

  /// Factory method to parse JSON into PostEventModel
  factory PostEventModel.fromJson(Map<String, dynamic> json) {
    return PostEventModel(
      event_name: json['event_name'] as String,
      event_type_id: json['event_type_id'] as String,
      visibility: json['visibility'] as String,
      topics: json['topics'] as String,
      eligibility: json['eligibility'] as String,
      registration_start_date: json['registration_start_date'] as String,
      registration_end_date: json['registration_end_date'] as String,
      event_start_date: json['event_start_date'] as String,
      event_end_date: json['event_end_date'] as String,
      about_this_event: json['about_this_event'] as String,
      event_description: json['event_description'] as String,
      registration_fee: json['registration_fee'] as String,
      // event_poster: json['event_poster'] as File,
      // event_images: (json['event_images'] as List<dynamic>).map((e) => e as File).toList(),
      // brochure: json['brochure'] as File,
      venue: json['venue'] as String,
    );
  }
}
