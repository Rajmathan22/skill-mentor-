import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillzmentors/Screens/jobs_screen/recent_job_details.dart';
import 'package:skillzmentors/ViewModel/jobs_bloc/job_bloc.dart';
import 'package:skillzmentors/Models/proflie_model/job_model.dart';
import 'package:skillzmentors/config/Images/jobes_image.dart';

class JobScreen extends StatefulWidget {
  @override
  _JobScreenState createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  final ScrollController _scrollController = ScrollController();
  late JobBloc _jobBloc;

  @override
  void initState() {
    super.initState();
    _jobBloc = context.read<JobBloc>();
    _jobBloc.add(FetchJobs(_jobBloc.currentPage));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if (_jobBloc.nextPageUrl != null) {
          _jobBloc.currentPage++;
          _jobBloc.add(FetchJobs(_jobBloc.currentPage));
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildJobsList(List<Job> jobs) {
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
                          recent.company.companyLogo.toString(),
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
                        recent.company.companyName,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'TimesNewRoman'),
                      ),
                      Text(
                        recent.salary,
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontFamily: 'TimesNewRoman'),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                      
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs'),
      ),
      body: BlocBuilder<JobBloc, JobState>(
        builder: (context, state) {
          if (state is JobLoading && state.jobs.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else if (state is JobLoaded) {
            return _buildJobsList(state.jobs);
          } else if (state is JobError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('No jobs available'));
          }
        },
      ),
    );
  }
}