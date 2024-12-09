import 'package:flutter/material.dart';

import 'package:skillzmentors/Components/appbar/app_bar.dart';
import 'package:skillzmentors/Screens/jobs_screen/job_screen_model.dart';
import 'package:skillzmentors/Screens/jobs_screen/recent_job_details.dart';
import 'package:skillzmentors/Screens/jobs_screen/recent_jobs_list_model.dart';

class FilterWorkPlace extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final List<RecentCompany> company;
  final String filterType;

  FilterWorkPlace({super.key, required this.company, required this.filterType});

  @override
  Widget build(BuildContext context) {
    List<RecentCompany> filteredCompanies =
        company.where((c) => c.workplace == filterType).toList();

    return Scaffold(
      appBar: AppBarBack(scaffoldKey: scaffoldKey),
      body: ListView.builder(
        itemCount: filteredCompanies.length,
        itemBuilder: (context, index) {
          var data = filteredCompanies[index];
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 6,
                ),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => RecentJobDetails(
                      //       company: data,
                      //     ),
                      //   ),
                      // );
                    },
                    child: RecentJobCard(
                      company: data,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class FilterWorkType extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final List<RecentCompany> company;
  final String filterType;

  FilterWorkType({Key? key, required this.company, required this.filterType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<RecentCompany> filteredCompanies =
        company.where((c) => c.jobtype == filterType).toList();

    return Scaffold(
      appBar: AppBarBack(scaffoldKey: scaffoldKey),
      body: ListView.builder(
        itemCount: filteredCompanies.length,
        itemBuilder: (context, index) {
          var data = filteredCompanies[index];
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 6,
                ),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => RecentJobDetails(
                      //       recentcompany: data,
                      //     ),
                      //   ),
                      // );
                    },
                    child: RecentJobCard(
                      company: data,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

//info: this is for filtering the jobs

class JobFilterScreen extends StatefulWidget {
  const JobFilterScreen({super.key});

  @override
  State<JobFilterScreen> createState() => _JobFilterScreenState();
}

class _JobFilterScreenState extends State<JobFilterScreen> {
  String? selectedJobType;
  String? selectedLocation;
  String? selectedExperienceLevel;
  double salaryRange = 50000;

  List<String> jobTypes = ['Full-time', 'Part-time', 'Contract', 'Internship'];
  List<String> locations = [
    'New York',
    'San Francisco',
    'Remote',
    'Los Angeles',
  ];
  List<String> experienceLevels = ['Entry', 'Mid-level', 'Senior', 'Lead'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Job Filters',
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Job Type',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              isExpanded: true,
              value: selectedJobType,
              hint: const Text('Select Job Type'),
              items: jobTypes.map((jobType) {
                return DropdownMenuItem(
                  value: jobType,
                  child: Text(jobType),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedJobType = value;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Location',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              isExpanded: true,
              value: selectedLocation,
              hint: const Text('Select Location'),
              items: locations.map((location) {
                return DropdownMenuItem(
                  value: location,
                  child: Text(location),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedLocation = value;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Experience Level',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              isExpanded: true,
              value: selectedExperienceLevel,
              hint: const Text('Select Experience Level'),
              items: experienceLevels.map((level) {
                return DropdownMenuItem(
                  value: level,
                  child: Text(level),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedExperienceLevel = value;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Salary Range',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: salaryRange,
              min: 30000,
              max: 150000,
              divisions: 12,
              label: '\$${salaryRange.round()}',
              onChanged: (value) {
                setState(() {
                  salaryRange = value;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Filters Applied'),
                    content: Text(
                      'Job Type: $selectedJobType\nLocation: $selectedLocation\nExperience Level: $selectedExperienceLevel\nSalary: \$${salaryRange.round()}',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Apply Filters',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
