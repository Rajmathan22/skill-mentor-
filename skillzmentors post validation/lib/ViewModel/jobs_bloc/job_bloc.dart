import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillzmentors/Models/proflie_model/job_model.dart';
import 'package:skillzmentors/Repositories/job_repository.dart';

// Events
abstract class JobEvent {}

class FetchJobs extends JobEvent {
  final int page;
  FetchJobs(this.page);
}

// States
abstract class JobState {}

class JobInitial extends JobState {}

class JobLoading extends JobState {
  final List<Job> jobs;
  JobLoading(this.jobs);
}

class JobLoaded extends JobState {
  final List<Job> jobs;
  final String? nextPageUrl;
  JobLoaded(this.jobs, this.nextPageUrl);
}

class JobError extends JobState {
  final String message;
  JobError(this.message);
}

// BLoC
class JobBloc extends Bloc<JobEvent, JobState> {
  final JobRepository jobRepository;
  int currentPage = 1;
  String? nextPageUrl;

  JobBloc(this.jobRepository) : super(JobInitial()) {
    on<FetchJobs>((event, emit) async {
      try {
        if (state is JobLoading) return;

        final currentState = state;
        List<Job> oldJobs = [];
        if (currentState is JobLoaded) {
          oldJobs = currentState.jobs;
        }

        emit(JobLoading(oldJobs));

        final result = await jobRepository.fetchJobs(event.page);
        final jobs = result['jobs'] as List<Job>;
        nextPageUrl = result['nextPageUrl'] as String?;

        emit(JobLoaded(oldJobs + jobs, nextPageUrl));
      } catch (e) {
        print("Data is not coming from the api $e");
        emit(JobError(e.toString()));
      }
    });
  }
}