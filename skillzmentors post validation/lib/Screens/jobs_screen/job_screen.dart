import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:skillzmentors/Components/appbar/default_app_bar.dart';
import 'package:skillzmentors/Models/proflie_model/job_model.dart';
import 'package:skillzmentors/ViewModel/jobs_bloc/job_bloc.dart';
import 'package:skillzmentors/config/Colors/colors.dart';
import 'package:skillzmentors/config/Images/jobes_image.dart';
import 'package:skillzmentors/Components/drawer/default_drawer.dart';
import 'package:skillzmentors/Screens/jobs_screen/filter_screen.dart';
import 'package:skillzmentors/Screens/jobs_screen/recent_job_details.dart';
import 'package:skillzmentors/Screens/jobs_screen/jobs_seemore.dart';

class JobScreen extends StatefulWidget {
  const JobScreen({super.key});

  @override
  State<JobScreen> createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  late JobBloc _jobBloc;

  bool _showDownArrow = false;
  int index = 2;

  @override
  void initState() {
    super.initState();
    //info: this  is for bloc implementation
    _jobBloc = context.read<JobBloc>();
    _jobBloc.add(FetchJobs(_jobBloc.currentPage));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _jobBloc.currentPage++;
        _jobBloc.add(FetchJobs(_jobBloc.currentPage));
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildImageSlider() {
    final List<String> imgList = [
      JobsImage.mono_logo,
      JobsImage.nike_logo,
      JobsImage.apple_logo,
      JobsImage.mono_logo,
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 170,
              aspectRatio: 16 / 9,
              viewportFraction: 0.95,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.15,
              scrollDirection: Axis.horizontal,
            ),
            items: imgList.map((item) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        children: [
                          Image.asset(
                            item,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withOpacity(0.1),
                                  Colors.black.withOpacity(0.5),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            left: 20,
                            right: 20,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Special Offer',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 10.0,
                                        color: Colors.black.withOpacity(0.3),
                                        offset: const Offset(2.0, 2.0),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Get 50% off on all courses this week!',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 8.0,
                                        color: Colors.black.withOpacity(0.3),
                                        offset: const Offset(2.0, 2.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.asMap().entries.map((entry) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  //info: down arrow button
  Widget _buildDownArrowButton() {
    return AnimatedOpacity(
        opacity: _showDownArrow ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: GestureDetector(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => RecentJobsSeemore(company: recentList),
            //   ),
            // );
          },
          child: const Center(
              child: Column(
            children: [
              SizedBox(
                height: 24,
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: Colors.blue,
                size: 38,
              ),
              SizedBox(
                height: 12,
              )
            ],
          )),
        ));
  }

  Widget _buildLevelBadge(String level) {
    return Container(
      width: 50,
      height: 25,
      decoration: BoxDecoration(
        color: level == "Senior"
            ? Colors.purple
            : (level == "Junior"
                ? const Color.fromARGB(255, 179, 162, 4)
                : Colors.purple),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          level,
          style:
              const TextStyle(color: Colors.white, fontFamily: 'TimesNewRoman'),
        ),
      ),
    );
  }

  Widget _buildJobTypeBadge(String jobType) {
    return Container(
      width: 60,
      height: 25,
      decoration: BoxDecoration(
        color: jobType == "Part Time"
            ? const Color.fromARGB(255, 3, 228, 244)
            : (jobType == "Full Time"
                ? Colors.green
                : Colors.lightBlueAccent.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          jobType,
          style:
              const TextStyle(color: Colors.white, fontFamily: 'TimesNewRoman'),
        ),
      ),
    );
  }

  Widget _buildApplyButton() {
    return Container(
      width: 60,
      height: 25,
      decoration: BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadius.circular(50),
      ),
      child: const Center(
        child: Text(
          "Apply",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'TimesNewRoman'),
        ),
      ),
    );
  }

  Widget _buildJobsList(List<Job> jobs) {
    print(jobs[0]);
    return ListView.builder(
      controller: _scrollController,
      itemCount: jobs.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemBuilder: (context, index) {
        var recent = jobs[index];
        return Padding(
          padding: const EdgeInsets.only(
            top: 4,
            left: 10,
            right: 10,
            bottom: 4,
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecentJobDetails(recentcompany: recent),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      width: 50,
                      height: 50,
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: Image.network(
                          recent.company.companyLogo ?? '',
                          width: 66,
                          height: 66,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              JobsImage.notfound,
                              width: 66,
                              height: 66,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      Text(
                        recent.company.companyName ?? '',
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'TimesNewRoman'),
                      ),
                      Text(
                        recent.salary ?? '',
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontFamily: 'TimesNewRoman'),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          _buildLevelBadge(recent.positionLevel ?? ''),
                          const SizedBox(width: 6),
                          _buildJobTypeBadge(recent.jobType ?? ''),
                          const SizedBox(width: 50),
                          _buildApplyButton(),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Scaffold(
            key: scaffoldKey,
            appBar: DefaultAppBar(
              scaffoldKey: scaffoldKey,
            ),
            backgroundColor: Colors.white,
            body: BlocBuilder<JobBloc, JobState>(builder: (context, state) {
              if (state is JobLoading) {
                return const Center(
                    child: SpinKitCircle(color: Colors.blue, size: 40.0));
              } else if (state is JobLoaded) {
                return NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                      if (!_showDownArrow) {
                        setState(() {
                          _showDownArrow = true;
                        });
                      }
                      return true;
                    } else if (_showDownArrow &&
                        scrollInfo.metrics.pixels <
                            scrollInfo.metrics.maxScrollExtent) {
                      setState(() {
                        _showDownArrow = false;
                      });
                    }
                    return false;
                  },
                  child: Stack(
                    children: [
                      ListView(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 12),
                                child: Text(
                                  "Hello Afsar",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      fontFamily: 'TimesNewRoman'),
                                ),
                              ),
                              const SizedBox(height: 6),
                              _buildImageSlider(),
                              const SizedBox(height: 6),
                              const Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "Find Your Jobes",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'TimesNewRoman'),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             FilterWorkType(
                                      //                 company: recentList,
                                      //                 filterType:
                                      //                     "Full Time")));
                                    },
                                    child: TypesOfJobs(
                                        imagePath: JobsImage.add_1,
                                        title: "Full Time"),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             FilterWorkType(
                                      //                 company: recentList,
                                      //                 filterType:
                                      //                     "Part Time")));
                                    },
                                    child: TypesOfJobs(
                                        imagePath: JobsImage.add_2,
                                        title: "Part Time"),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             FilterWorkPlace(
                                      //                 company: recentList,
                                      //                 filterType: "Remote")));
                                    },
                                    child: TypesOfJobs(
                                        imagePath: JobsImage.add_3,
                                        title: "Remote Jobes"),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             FilterWorkType(
                                      //                 company: recentList,
                                      //                 filterType:
                                      //                     "Internship")));
                                    },
                                    child: TypesOfJobs(
                                        imagePath: JobsImage.add_4,
                                        title: "InternShip"),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Recent Jobs",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'TimesNewRoman'),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                RecentJobsSeemore(
                                                    company: state.jobs),
                                          ),
                                        );
                                      },
                                      //fixme: under implementation
                                      child: const Column(
                                        children: [
                                          Text(
                                            "See More",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'TimesNewRoman'),
                                          ),
                                          SizedBox(height: 12),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              _buildJobsList(state.jobs),
                              const SizedBox(
                                height: 36,
                              )
                            ],
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: _buildDownArrowButton(),
                      ),
                    ],
                  ),
                );
              } else if (state is JobError) {
                return Center(child: Text(state.message));
              } else {
                return Center(child: Text('Press the button to fetch jobs'));
              }
            })));
  }
}

//note: this is for displaying the jobs

class TypesOfJobs extends StatelessWidget {
  final String imagePath;
  final String title;

  const TypesOfJobs({
    super.key,
    required this.imagePath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.blue,
          width: 2.0,
        ),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 10,
            left: 30,
            child: Text(
              title,
              style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  fontFamily: 'TimesNewRoman'),
            ),
          ),
        ],
      ),
    );
  }
}
