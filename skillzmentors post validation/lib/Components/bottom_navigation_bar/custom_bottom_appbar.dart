import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:skillzmentors/Repositories/job_repository.dart';
import 'package:skillzmentors/Screens/course_screen/course_home.dart';
import 'package:skillzmentors/Screens/event_screen/event_home.dart';
import 'package:skillzmentors/Screens/home_screen/home.dart';
import 'package:skillzmentors/Screens/jobs_screen/job_screen.dart';
import 'package:skillzmentors/Screens/profile/profile/profile_home.dart';
import 'package:skillzmentors/ViewModel/home_bloc/home_bloc.dart';
import 'package:skillzmentors/ViewModel/jobs_bloc/job_bloc.dart';

class CustomBottomAppbar extends StatefulWidget {
  const CustomBottomAppbar({super.key});

  @override
  State<CustomBottomAppbar> createState() => _CustomBottomAppbarState();
}

class _CustomBottomAppbarState extends State<CustomBottomAppbar> {
  //final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 0;

  final screens = [
    BlocProvider(
      create: (context) => HomeBloc()..add(HomeInitialEvent()),
      child: HomeScreen(),
    ),
    HomeScreenEvent(),
    BlocProvider(
      create: (context) => JobBloc(JobRepository()),
      child: JobScreen(),
    ),
    CourseHomePage(),
    ProfileHome()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 12, right: 12, left: 12, top: 8),
        child: GNav(
          color: Colors.grey,
          tabs: const [
            GButton(
              icon: Icons.home,
              text: "Home",
            ),
            GButton(
              icon: Icons.event,
              text: "Events",
            ),
            GButton(
              icon: Icons.work_outline,
              text: "Jobs",
            ),
            GButton(
              icon: Icons.school,
              text: "Courses",
            ),
            GButton(
              icon: Icons.person,
              text: "Profile",
            ),
          ],
          gap: 6,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          iconSize: 26,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          tabBorderRadius: 100,
          selectedIndex: index,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.blue,
          duration: Duration(milliseconds: 600),
          onTabChange: (index) {
            setState(() {
              this.index = index;
            });
          },
        ),
      ),
    );
  }
}
