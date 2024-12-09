import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:skillzmentors/Components/AppBar/default_app_bar.dart';

import 'attanance_indicaor.dart';
import 'profile_options.dart';
import 'package:skillzmentors/config/Images/jobes_image.dart';

class ProfileHome extends StatefulWidget {
  const ProfileHome({super.key});

  @override
  State<ProfileHome> createState() => _ProfileHomeState();
}

class _ProfileHomeState extends State<ProfileHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const DefaultAppBar(),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //info: menu button
                const SizedBox(
                  height: 12,
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilePage())),
                  child: Container(
                    width: 70,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF9E60F9),
                          Color(0xFFDE81FF),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: StreamBuilder<Object>(
                        stream: null,
                        builder: (context, snapshot) {
                          return const Center(
                              child: Text(
                            "Menu",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'TimesNewRoman',
                            ),
                          ));
                        }),
                  ),
                ),

                const SizedBox(height: 20),
                Stack(
                  children: [
                    Container(
                      height: 140,
                      color: Colors.transparent,
                    ),
                    SizedBox(
                      height: 90,
                      child: Image.asset(
                        JobsImage.bannerwithname,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 55,
                      left: 15,
                      child: Container(
                        width: 70,
                        height: 70,
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 4,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey[200],
                          backgroundImage: AssetImage(JobsImage.apple_logo),
                        ),
                      ),
                    ),
                  ],
                ),

                //info: profile name
                const Row(
                  children: [
                    SizedBox(width: 15),
                    Text(
                      "Jhon Dio",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'TimesNewRoman',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: _nameContainer("CSE", "3", "7.9", "2021-2025"),
                ),
                const SizedBox(height: 20),
                //info: total class
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total Class",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'TimesNewRoman',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "See More",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'TimesNewRoman',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _todayclasscontainer("Maths", "10:00 AM - 11:00 AM"),
                    _todayclasscontainer("Maths", "10:00 AM - 11:00 AM"),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Submission Task",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'TimesNewRoman',
                  ),
                ),
                const SizedBox(height: 10),
                _tasksubmission("Maths", "Assignment 1", "2021-10-10"),
                const SizedBox(height: 10),
                _tasksubmission("Enlish", "Assignment 1", "2021-10-10"),
                const SizedBox(height: 20),
                const Text(
                  "Overall Attanance",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'TimesNewRoman',
                  ),
                ),
                const SizedBox(height: 12),
                const Center(
                  child: AttendanceIndicator(attendanceValue: 50),
                ),
                const SizedBox(
                  height: 70,
                ),
                Center(
                  child: Text(
                    "For More details visit: Menu",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'TimesNewRoman',
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        )));
  }

  //info: name container
  Widget _nameContainer(String department, String semester, String currentcgpt,
      String accedemicyear) {
    return Container(
        width: double.infinity,
        height: 180,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          gradient: const LinearGradient(
            colors: [
              Color(0xFF9E60F9),
              Color(0xFFDE81FF),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.black,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 24, left: 12, right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Department:",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: 'TimesNewRoman',
                          fontWeight: FontWeight.bold)),
                  const SizedBox(width: 10),
                  Text(
                    department,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue[900],
                        fontFamily: 'TimesNewRoman',
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Semester",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: 'TimesNewRoman',
                          fontWeight: FontWeight.bold)),
                  const SizedBox(width: 10),
                  Text(
                    semester,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue[900],
                      fontWeight: FontWeight.bold,
                      fontFamily: 'TimesNewRoman',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Current CGPT",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: 'TimesNewRoman',
                          fontWeight: FontWeight.bold)),
                  const SizedBox(width: 10),
                  Text(
                    currentcgpt,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue[900],
                      fontWeight: FontWeight.bold,
                      fontFamily: 'TimesNewRoman',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Accedemic Year",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: 'TimesNewRoman',
                          fontWeight: FontWeight.bold)),
                  const SizedBox(width: 10),
                  Text(
                    accedemicyear,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue[900],
                      fontWeight: FontWeight.bold,
                      fontFamily: 'TimesNewRoman',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  //info: today class container
  Widget _todayclasscontainer(String subject, String time) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.white, Color(0xFFE1BEE7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              subject,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'TimesNewRoman',
              ),
            ),
            Text(
              time,
              style: TextStyle(
                color: Colors.blue[900],
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'TimesNewRoman',
              ),
            ),
          ],
        ),
      ),
    );
  }

  //info: submission task container
  Widget _tasksubmission(
      String tasksubject, String taskname, String submissiondate) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFE3F2FD), Color(0xFF90CAF9)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, left: 50, right: 12, bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    tasksubject,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'TimesNewRoman',
                    ),
                  ),
                  Text(
                    taskname,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'TimesNewRoman',
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const HugeIcon(
                          icon: HugeIcons.strokeRoundedClock01,
                          size: 11,
                          color: Colors.black),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          submissiondate,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'TimesNewRoman',
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
