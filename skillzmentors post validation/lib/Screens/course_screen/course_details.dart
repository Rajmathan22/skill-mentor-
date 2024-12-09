import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:skillzmentors/Components/appbar/app_bar_withoutlogo.dart';
import 'package:skillzmentors/Screens/course_screen/course_test_data.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CourseDetails extends StatelessWidget {
  final int id;
  const CourseDetails({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final course = coursesData.firstWhere(
      (course) => course['id'] == id,
      orElse: () => null,
    );

    final videoId = YoutubePlayer.convertUrlToId(course['demo_video']) ?? '';

    return Scaffold(
      appBar: AppBarForDetails(
        companyname: course['title'],
        scaffoldKey: scaffoldKey,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YoutubePlayer(
                  onEnded: (_) {},
                  controller: YoutubePlayerController(
                    initialVideoId: videoId,
                    flags: const YoutubePlayerFlags(
                      autoPlay: true,
                      mute: true,
                      loop: true,
                    ),
                  ),
                  showVideoProgressIndicator: true,
                  onReady: () {
                    print('Player is ready.');
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          RatingBar.builder(
                            initialRating: course['stars'].toDouble(),
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 20,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Color.fromARGB(255, 250, 187, 0),
                            ),
                            onRatingUpdate: (rating) {},
                            ignoreGestures: true,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            course['stars'].toString(),
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'TimesNewRoman'),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "(${course['reviews']} reviews)",
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                                fontFamily: 'TimesNewRoman'),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        course['title'],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'TimesNewRoman',
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        course['description'],
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                            height: 1.5,
                            fontFamily: 'TimesNewRoman'),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${course['enrolled']} students enrolled",
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'TimesNewRoman'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildSectionTitle('What you\'ll learn'),
                      const SizedBox(
                        height: 12,
                      ),
                      _buildLearningPoints(course['what_you_learn']),

                      const SizedBox(height: 20),
                      _buildSectionTitle('Course Content'),
                      const SizedBox(
                        height: 12,
                      ),
                      _buildCourseSyllabus(course['course_syllabus']),

                      const SizedBox(height: 20),
                      _buildSectionTitle('Requirements'),
                      const SizedBox(
                        height: 12,
                      ),
                      _buildRequirements(course['requirements']),
                      const SizedBox(height: 50),
                      const Text(
                        "Instructor",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'TimesNewRoman'),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey[300],
                            child: Text(
                              course['instructor'][0],
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'TimesNewRoman'),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  course['instructor'],
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'TimesNewRoman'),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Professional Instructor",
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                      fontFamily: 'TimesNewRoman'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 100), // Space for bottom button
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Price",
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                              fontFamily: 'TimesNewRoman'),
                        ),
                        Text(
                          "₹${course['price']}",
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontFamily: 'TimesNewRoman'),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print("Enroll button pressed");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Enroll Now',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'TimesNewRoman',
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'TimesNewRoman'),
      ),
    );
  }

  Widget _buildLearningPoints(List<dynamic> points) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: points
            .map((point) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.check, color: Colors.green, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          point,
                          style: const TextStyle(
                              fontSize: 16, fontFamily: 'TimesNewRoman'),
                        ),
                      ),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildCourseSyllabus(List<dynamic> syllabus) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: syllabus.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(
              'Section ${index + 1}: ${syllabus[index]}',
              style: const TextStyle(fontSize: 16, fontFamily: 'TimesNewRoman'),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: const [
                    Icon(Icons.play_circle_outline),
                    SizedBox(width: 8),
                    Text(
                      'Lecture content will be here',
                      style: TextStyle(fontFamily: 'TimesNewRoman'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildRequirements(List<dynamic> requirements) {
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: requirements
              .map((req) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.fiber_manual_record, size: 8),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            req,
                            style: const TextStyle(
                                fontSize: 16, fontFamily: 'TimesNewRoman'),
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ));
  }
}
