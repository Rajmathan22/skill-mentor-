import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:skillzmentors/Screens/event_screen/event_type_model.dart';
import 'package:skillzmentors/Screens/event_screen/events_model.dart';

List<EventTypeModel> getEventTypes() {
  List<EventTypeModel> eventTypes = [];

  eventTypes.add(EventTypeModel(
    icon: const HugeIcon(icon: HugeIcons.strokeRoundedArrangeByLettersAZ, color: Color(0xff102733)), // Ensure HugeIcon type
    eventType: "All Event",
  ),
  );
  eventTypes.add(
    EventTypeModel(
      icon: const HugeIcon(
          icon: HugeIcons.strokeRoundedComputerProgramming01,
          color: Color(0xff102733)), // Ensure HugeIcon type
      eventType: "Hackathon",
    ),
  );
  eventTypes.add(
    EventTypeModel(
      icon: const HugeIcon(
          icon: HugeIcons.strokeRoundedTableTennisBat,
          color: Color(0xff102733)),
      // Ensure HugeIcon type
      eventType: "Sports",
    ),
  );
  eventTypes.add(
    EventTypeModel(
      icon: const HugeIcon(
          icon: HugeIcons.strokeRoundedMortarboard02, color: Color(0xff102733)),
      // Ensure HugeIcon type
      eventType: "Academic",
    ),
  );
  return eventTypes;
}

List<String> getLocations() {
  List<String> locations = [];

  locations.add("All");
  locations.add("Chennai");
  locations.add("Coimbatore");
  locations.add("Madurai");
  locations.add("Trichy");
  locations.add("Salem");
  locations.add("Tirunelveli");
  locations.add("Vellore");
  locations.add("Tiruppur");
  locations.add("Erode");
  locations.add("Tiruvannamalai");
  locations.add("Thanjavur");
  locations.add("Dindigul");
  locations.add("Karur");
  locations.add("Nagercoil");
  locations.add("Namakkal");
  locations.add("Rajapalayam");
  locations.add("Sivakasi");
  locations.add("Pudukkottai");
  locations.add("Hosur");
  locations.add("Avadi");
  locations.add("Kancheepuram");
  locations.add("Karaikudi");
  locations.add("Neyveli");
  locations.add("Cuddalore");
  locations.add("Kumbakonam");
  locations.add("Tiruvallur");

  return locations;
}

const String jsonData = '''
  [
    {
      "eventName": "Simplifiya",
      "eventType": "Academic",
      "topics": "Data Science, Python",
      "eligibility": "Open to all",
      "registrationStartDate": "5th April 2021",
      "registrationEndDate": "15th April 2021",
      "eventStartDate": "20th April 2021",
      "eventEndDate": "21th April 2021",
      "eventStartTime": "10:00 AM",
      "eventEndTime": "5:00 PM",
      "aboutThisEvent": "Data science workshop.",
      "eventDescription": "Learn Data science from experts.",
      "eventPoster": "assets/images/tileimg.png",
      "eventImages": [
        "assets/images/tileimg.png", 
        "assets/images/Hackathon.png", 
        "assets/images/Sports.png", 
        "assets/images/second.png"
      ],
      "brochure": "assets/images/brochures/data_science_workshop.pdf",
      "collegeName": "IIT Madras",
      "venue": "Chennai",
      "collegeAddress": "IIT Madras, Chennai",
      "price": "₹1000"
    },
    {
      "eventName": "EcoSummit",
      "eventType": "Academic",
      "topics": "Sustainable Energy",
      "eligibility": "Open to all",
      "registrationStartDate": "12th June 2021",
      "registrationEndDate": "20th June 2021",
      "eventStartDate": "25th June 2021",
      "eventEndDate": "25th June 2021",
      "eventStartTime": "10:00 AM",
      "eventEndTime": "5:00 PM",
      "aboutThisEvent": "A seminar on sustainable energy.",
      "eventDescription": "Explore sustainable energy solutions.",
      "eventPoster": "assets/images/second.png",
      "eventImages": [
        "assets/images/tileimg.png", 
        "assets/images/Hackathon.png", 
        "assets/images/Sports.png", 
        "assets/images/second.png"
      ],
      "brochure": "assets/images/brochures/energy_seminar.pdf",
      "collegeName": "Anna University",
      "venue": "Chennai",
      "collegeAddress": "Anna University, Chennai",
      "price": "Free"
    },
    {
      "eventName": "Hackathon 2021",
      "eventType": "Hackathon",
      "topics": "Web Development, App Development",
      "eligibility": "Open to all",
      "registrationStartDate": "1st May 2021",
      "registrationEndDate": "10th May 2021",
      "eventStartDate": "15th May 2021",
      "eventEndDate": "15th May 2021",
      "eventStartTime": "10:00 AM",
      "eventEndTime": "5:00 PM",
      "aboutThisEvent": "A hackathon for developers.",
      "eventDescription": "Develop web and mobile applications.",
      "eventPoster": "assets/images/Hackathon.png",
      "eventImages": [
        "assets/images/tileimg.png", 
        "assets/images/Hackathon.png", 
        "assets/images/Sports.png", 
        "assets/images/second.png"
      ],
      "brochure": "assets/images/brochures/hackathon.pdf",
      "collegeName": "VIT",
      "venue": "Vellore",
      "collegeAddress": "VIT, Vellore",
      "price": "₹500"
    },
    {
      "eventName": "Sports Meet",
      "eventType": "Sports",
      "topics": "Cricket, Football",
      "eligibility": "Open to all",
      "registrationStartDate": "10th July 2021",
      "registrationEndDate": "20th July 2021",
      "eventStartDate": "25th July 2021",
      "eventEndDate": "25th July 2021",
      "eventStartTime": "10:00 AM",
      "eventEndTime": "5:00 PM",
      "aboutThisEvent": "A sports meet for sports enthusiasts.",
      "eventDescription": "Participate in cricket and football matches.",
      "eventPoster": "assets/images/tileimg.png",
      "eventImages": [
        "assets/images/tileimg.png", 
        "assets/images/Hackathon.png", 
        "assets/images/Sports.png", 
        "assets/images/second.png"
      ],
      "brochure": "assets/images/brochures/sports_meet.pdf",
      "collegeName": "SRM",
      "venue": "Chennai",
      "collegeAddress": "SRM, Chennai",
      "price": "₹300"
    },
    {
      "eventName": "Music Fest",
      "eventType": "Music",
      "topics": "Music, Dance",
      "eligibility": "Open to all",
      "registrationStartDate": "5th August 2021",
      "registrationEndDate": "15th August 2021",
      "eventStartDate": "20th August 2021",
      "eventEndDate": "20th August 2021",
      "eventStartTime": "10:00 AM",
      "eventEndTime": "5:00 PM",
      "aboutThisEvent": "A music fest for music lovers.",
      "eventDescription": "Enjoy music and dance performances.",
      "eventPoster": "assets/images/second.png",
      "eventImages": [
        "assets/images/tileimg.png", 
        "assets/images/Hackathon.png", 
        "assets/images/Sports.png", 
        "assets/images/second.png"
      ],
      "brochure": "assets/images/brochures/music_fest.pdf",
      "collegeName": "IIT Madras",
      "venue": "Chennai",
      "collegeAddress": "IIT Madras, Chennai",
      "price": "₹200"
    },
    {
      "eventName": "Tech Fest",
      "eventType": "Tech",
      "topics": "Technology, Innovation",
      "eligibility": "Open to all",
      "registrationStartDate": "1st September 2021",
      "registrationEndDate": "10th September 2021",
      "eventStartDate": "15th September 2021",
      "eventEndDate": "15th September 2021",
      "eventStartTime": "10:00 AM",
      "eventEndTime": "5:00 PM",
      "aboutThisEvent": "A tech fest for tech enthusiasts.",
      "eventDescription": "Explore new technologies and innovations.",
      "eventPoster": "assets/images/second.png",
      "eventImages": [
        "assets/images/tileimg.png", 
        "assets/images/Hackathon.png", 
        "assets/images/Sports.png", 
        "assets/images/second.png"
      ],
      "brochure": "assets/images/brochures/tech_fest.pdf",
      "collegeName": "VIT",
      "venue": "Vellore",
      "collegeAddress": "VIT, Vellore",
      "price": "₹400"
    },
    {
      "eventName": "Cultural Fest",
      "eventType": "Cultural",
      "topics": "Culture, Tradition",
      "eligibility": "Open to all",
      "registrationStartDate": "5th October 2021",
      "registrationEndDate": "15th October 2021",
      "eventStartDate": "20th October 2021",
      "eventEndDate": "20th October 2021",
      "eventStartTime": "10:00 AM",
      "eventEndTime": "5:00 PM",
      "aboutThisEvent": "A cultural fest for cultural enthusiasts.",
      "eventDescription": "Experience different cultures and traditions.",
      "eventPoster": "assets/images/tileimg.png",
      "eventImages": [
        "assets/images/tileimg.png", 
        "assets/images/Hackathon.png", 
        "assets/images/Sports.png", 
        "assets/images/second.png"
      ],
      "brochure": "assets/images/brochures/cultural_fest.pdf",
      "collegeName": "Anna University",
      "venue": "Chennai",
      "collegeAddress": "Anna University, Chennai",
      "price": "₹300"
    },
    {
      "eventName": "Food Fest",
      "eventType": "Food",
      "topics": "Food, Cuisine",
      "eligibility": "Open to all",
      "registrationStartDate": "1st November 2021",
      "registrationEndDate": "10th November 2021",
      "eventStartDate": "15th November 2021",
      "eventEndDate": "15th November 2021",
      "eventStartTime": "10:00 AM",
      "eventEndTime": "5:00 PM",
      "aboutThisEvent": "A food fest for food lovers.",
      "eventDescription": "Taste different cuisines and food items.",
      "eventPoster": "assets/images/second.png",
      "eventImages": [
        "assets/images/tileimg.png", 
        "assets/images/Hackathon.png", 
        "assets/images/Sports.png", 
        "assets/images/second.png"
      ],
      "brochure": "assets/images/brochures/food_fest.pdf",
      "collegeName": "SRM",
      "venue": "Chennai",
      "collegeAddress": "SRM, Chennai",
      "price": "₹200"
    }
  ]
''';

List<EventsModel> getEvents() {
  final List<dynamic> decodedJson = jsonDecode(jsonData);
  return decodedJson.map((json) => EventsModel.fromJson(json)).toList();
}

