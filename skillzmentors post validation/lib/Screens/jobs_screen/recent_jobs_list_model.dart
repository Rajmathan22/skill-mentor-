import 'package:flutter/material.dart';
import 'package:skillzmentors/config/Colors/colors.dart';
import 'package:skillzmentors/Screens/jobs_screen/job_screen_model.dart';

class RecentJobCard extends StatelessWidget {
  final RecentCompany? company;
  const RecentJobCard({super.key, this.company});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.7),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      company!.job!,
                      style: const TextStyle(
                          color: white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'TimesNewRoman',
                          fontSize: 16),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.money,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          company?.sallary ?? '',
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'TimesNewRoman'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_on),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          company?.location ?? '',
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'TimesNewRoman'),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Container(
                            width: 60,
                            height: 25,
                            decoration: BoxDecoration(
                              color: company!.jobtype == "Part Time"
                                  ? const Color.fromARGB(255, 255, 165, 0)
                                  : (company!.jobtype == "Full Time"
                                      ? Colors.green
                                      : (company!.jobtype == "Internship"
                                          ? const Color.fromARGB(
                                              255, 64, 224, 208)
                                          : Colors.white)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                company!.jobtype!,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'TimesNewRoman'),
                              ),
                            )),
                        const SizedBox(
                          width: 16,
                        ),
                        Container(
                            width: 60,
                            height: 25,
                            decoration: BoxDecoration(
                              color: company!.workplace == "Remote"
                                  ? const Color.fromARGB(255, 3, 169, 244)
                                  : const Color.fromARGB(255, 255, 152, 0),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                company!.workplace!,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'TimesNewRoman'),
                              ),
                            )),
                      ],
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              color: Colors.black,
              width: double.infinity,
              height: 1,
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Experience: ${company?.experiencelevel ?? "Null"}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'TimesNewRoman'),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      company?.companyName ?? '',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'TimesNewRoman'),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: null),
                      child: ClipOval(
                        child: Image.asset(
                          company!.image!,
                          width: 66,
                          height: 66,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
