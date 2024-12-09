import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<InstagramNotification> notifications = [];

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/notification_data.json');
    final data = json.decode(response);

    setState(() {
      notifications = data['notifications']
          .map<InstagramNotification>(
              (data) => InstagramNotification.fromJson(data))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Activity",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: notifications.isNotEmpty
          ? SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true, // Allows ListView to be inside a Column
                    physics:
                        const NeverScrollableScrollPhysics(), // Prevents independent scrolling
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: ValueKey(notifications[index].id),
                        direction: DismissDirection.endToStart,
                        background: slideBackground(),
                        onDismissed: (direction) {
                          setState(() {
                            notifications.removeAt(index);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Notification deleted")),
                          );
                        },
                        child: notificationItem(notifications[index]),
                      );
                    },
                  ),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Widget slideBackground() {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      color: Colors.red,
      child: const Icon(Icons.delete, color: Colors.white),
    );
  }

  Widget notificationItem(InstagramNotification notification) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                notification.hasStory
                    ? Container(
                        width: 50,
                        height: 50,
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [Colors.red, Colors.orangeAccent],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomLeft),
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.white, width: 3)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(notification.profilePic),
                          ),
                        ),
                      )
                    : Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.grey.shade300, width: 1)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(notification.profilePic),
                        ),
                      ),
                const SizedBox(width: 10),
                Flexible(
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: notification.name,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: notification.content,
                          style: const TextStyle(color: Colors.black)),
                      TextSpan(
                        text: notification.timeAgo,
                        style: TextStyle(color: Colors.grey.shade500),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
          notification.postImage.isNotEmpty
              ? Container(
                  width: 50,
                  height: 50,
                  child: ClipRRect(
                    child: Image.network(notification.postImage),
                  ),
                )
              : Container(), // Replaced the Follow button with an empty container
        ],
      ),
    );
  }
}

class InstagramNotification {
  final String id;
  final String name;
  final String content;
  final String timeAgo;
  final String profilePic;
  final String postImage;
  final bool hasStory;

  InstagramNotification({
    required this.id,
    required this.name,
    required this.content,
    required this.timeAgo,
    required this.profilePic,
    required this.postImage,
    required this.hasStory,
  });

  factory InstagramNotification.fromJson(Map<String, dynamic> json) {
    return InstagramNotification(
      id: json['name'],
      name: json['name'] ?? '',
      content: json['content'] ?? '',
      timeAgo: json['timeAgo'] ?? '',
      profilePic: json['profilePic'] ?? '',
      postImage: json['postImage'] ?? '',
      hasStory: json['hasStory'] ?? false,
    );
  }
}
