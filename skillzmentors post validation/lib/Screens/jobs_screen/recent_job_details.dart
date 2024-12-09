import 'package:flutter/material.dart';
import 'package:skillzmentors/Components/appbar/app_bar_withoutlogo.dart';
import 'package:skillzmentors/Models/proflie_model/job_model.dart';
import 'package:skillzmentors/Screens/jobs_screen/job_screen_model.dart';
import 'package:skillzmentors/config/Images/jobes_image.dart';
import 'package:url_launcher/url_launcher.dart';

class RecentJobDetails extends StatefulWidget {
  final Job? recentcompany;
  const RecentJobDetails({super.key, this.recentcompany});

  @override
  State<RecentJobDetails> createState() => _RecentJobDetailsState();
}

class _RecentJobDetailsState extends State<RecentJobDetails> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isExpandedDisc = false;

  //info: for launch the URL
  Future<void> _launchURL(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarForDetails(
          scaffoldKey: scaffoldKey,
          companyname: widget.recentcompany!.company.companyName),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 35),
                          width: double.infinity,
                          height: 100,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 25,
                              ),
                              Text(
                                widget.recentcompany!.jobTitle,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: 'TimesNewRoman'),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Google",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontFamily: 'TimesNewRoman'),
                                  ),
                                  Container(
                                    width: 3,
                                    height: 3,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                  ),
                                  Text(
                                    widget.recentcompany!.jobType,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontFamily: 'TimesNewRoman'),
                                  ),
                                  Container(
                                    width: 3,
                                    height: 3,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                  ),
                                  const Text(
                                    "12 Days Ago",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontFamily: 'TimesNewRoman'),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Container(
                              width: 70,
                              height: 70,
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: null),
                              child: ClipOval(
                                child: Image.asset(
                                  widget.recentcompany!.company.companyLogo.toString(),
                                  width: 66,
                                  height: 66,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      JobsImage.notfound,
                                      width: 8,
                                      height: 8,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: Colors.yellow,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.attach_money,
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Sallary",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontFamily: 'TimesNewRoman'),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              widget.recentcompany!.salary,
                              style: const TextStyle(
                                  fontSize: 16, fontFamily: 'TimesNewRoman'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Column(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 179, 214, 180),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.business_outlined,
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Job Type",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontFamily: 'TimesNewRoman'),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              widget.recentcompany!.jobType,
                              style: const TextStyle(
                                  fontSize: 16, fontFamily: 'TimesNewRoman'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Column(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: Colors.yellow,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.work,
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Position",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontFamily: 'TimesNewRoman'),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              widget.recentcompany!.positionLevel,
                              style: const TextStyle(
                                  fontSize: 16, fontFamily: 'TimesNewRoman'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Text(
                      "Qualifications",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'TimesNewRoman'),
                    ),
                    Text("widget.recentcompany!.qualification",
                        style: const TextStyle(
                            fontSize: 16, fontFamily: 'TimesNewRoman')),
                    const SizedBox(
                      height: 6,
                    ),
                    const Text(
                      "Skills Needed",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'TimesNewRoman'),
                    ),
                    //fixme: need to implement the skills needed
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: widget.company!.skillsneed!.map((skill) {
                    //     return Padding(
                    //       padding: const EdgeInsets.symmetric(vertical: 2.0),
                    //       child: Row(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           const Text("• ",
                    //               style: TextStyle(
                    //                   fontSize: 16,
                    //                   fontFamily: 'TimesNewRoman')),
                    //           Expanded(
                    //             child: Text(
                    //               skill,
                    //               style: const TextStyle(
                    //                   fontSize: 16,
                    //                   fontFamily: 'TimesNewRoman'),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     );
                    //   }).toList(),
                    // ),
                    const SizedBox(height: 12),
                    const Text(
                      "About",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'TimesNewRoman'),
                    ),
                    Text(
                      "widget.recentcompany!.about",
                      style: const TextStyle(
                          fontSize: 16, fontFamily: 'TimesNewRoman'),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    const Text(
                      "Description",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'TimesNewRoman'),
                    ),
                    Text(
                      widget.recentcompany!.jobDescription,
                      style: const TextStyle(
                          fontSize: 16, fontFamily: 'TimesNewRoman'),
                    ),
                    

                    const SizedBox(
                      height: 6,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  print("This Apply Field is Not Yet Implemented");
                  _launchURL(widget.recentcompany!.link);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                  minimumSize: const Size(300, 50),
                ),
                child: const Text(
                  'Apply Now',
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'TimesNewRoman'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
