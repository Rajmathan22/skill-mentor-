import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:skillzmentors/Components/AppBar/app_bar_withbackbutton.dart';
import 'package:skillzmentors/Screens/profile/profile/Announcment_screen.dart';
import 'package:skillzmentors/Screens/profile/profile/Assignment_Screen.dart';
import 'package:skillzmentors/Screens/profile/profile/Examtable_screen.dart';
import 'package:skillzmentors/Screens/profile/profile/Leave_Screen.dart';
import 'package:skillzmentors/Screens/profile/profile/library_screen.dart';
import 'package:skillzmentors/Screens/profile/profile/report_screen.dart';
import 'package:skillzmentors/Screens/profile/profile/todotask_screen.dart';
import 'package:skillzmentors/ViewModel/Profilebloc/announcement_bloc.dart';
import 'package:skillzmentors/ViewModel/Profilebloc/announcement_event.dart';
import 'package:skillzmentors/ViewModel/Profilebloc/assignment_bloc.dart';
import 'package:skillzmentors/ViewModel/Profilebloc/assignment_event.dart';
import 'package:skillzmentors/ViewModel/Profilebloc/leave_bloc.dart';
import 'package:skillzmentors/ViewModel/Profilebloc/library_bloc.dart';
import 'package:skillzmentors/ViewModel/Profilebloc/library_event.dart';
import 'package:skillzmentors/ViewModel/Profilebloc/report_bloc.dart';
import 'attanance_indicaor.dart';
import 'games_screen.dart';
import 'package:skillzmentors/config/Images/jobes_image.dart';
import 'classTimetable_Screen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithBackButton(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //info: profile banner and image
              Stack(
                children: [
                  Container(
                    height: 150,
                    color: Colors.transparent,
                  ),
                  SizedBox(
                    height: 140,
                    child: Image.asset(
                      JobsImage.banner,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 15,
                    child: Container(
                      width: 80,
                      height: 80,
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
                  const Positioned(
                      top: 55,
                      left: 110,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Jhon Dio",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "BSc in Computer Science",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              //info:to display the featurs of the profile
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 10.0,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AttendanceScreen(),
                          ),
                        );
                      },
                      child: buildfeatures(Icons.calendar_today, "Attendance"),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) =>
                                  AssignmentBloc()..add(LoadAssignments()),
                              child: AssignmentScreen(),
                            ),
                          ),
                        );
                      },
                      child: buildfeatures(
                          HugeIcons.strokeRoundedAssignments, "Assignment"),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExamtableScreen(),
                          ),
                        );
                      },
                      child:
                          buildfeatures(Icons.edit_note_rounded, "Exam Table"),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClassTimetableScreen(),
                          ),
                        );
                      },
                      child: buildfeatures(HugeIcons.strokeRoundedTimeQuarter,
                          "Class TimeTable"),
                    ),
                    buildfeatures(HugeIcons.strokeRoundedMoney03, "Fees"),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) =>
                                  LibraryBloc()..add(LoadBooks()),
                              child: LibraryScreen(),
                            ),
                          ),
                        );
                      },
                      child: buildfeatures(
                          HugeIcons.strokeRoundedBook04, "Library (E-books)"),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => LeaveBloc(),
                              child: LeaveScreen(),
                            ),
                          ),
                        );
                      },
                      child: buildfeatures(
                          HugeIcons.strokeRoundedTaskDaily01, "Apply Leave"),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TodoTaskScreen(),
                          ),
                        );
                      },
                      child: buildfeatures(
                          HugeIcons.strokeRoundedCalendarDownload01, "Tasks"),
                    ),
                    buildfeatures(
                        HugeIcons.strokeRoundedBookEdit, "Exam Results"),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) =>
                                  AnnouncementBloc()..add(FetchAnnouncements()),
                              child: AnnouncmentScreen(),
                            ),
                          ),
                        );
                      },
                      child: buildfeatures(
                          Icons.mark_chat_unread_outlined, "Announcement"),
                    ),
                    buildfeatures(
                        HugeIcons.strokeRoundedCalendarRemove02, "Calendar"),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GamesScreen(),
                          ),
                        );
                      },
                      child: buildfeatures(Icons.gamepad, "Games"),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => UserReportBloc(),
                              child: ReportScreen(),
                            ),
                          ),
                        );
                      },
                      child: buildfeatures(
                          HugeIcons.strokeRoundedSchoolReportCard, "Report"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildfeatures(IconData iconData, String featureName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[300],
          ),
          child: Icon(
            iconData,
            size: 32,
            color: Colors.blue[800],
          ),
        ),
        const SizedBox(height: 5),
        Flexible(
          child: Text(
            featureName,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget buildEducationItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProfileActionItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Icon(icon, size: 28, color: Colors.blueAccent),
            const SizedBox(width: 16),
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
