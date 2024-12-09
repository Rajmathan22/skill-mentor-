import 'package:bloc/bloc.dart';
import 'package:skillzmentors/Models/proflie_model/announcement_model.dart';
import 'announcement_event.dart';
import 'announcement_state.dart';

class AnnouncementBloc extends Bloc<AnnouncementEvent, AnnouncementState> {
  AnnouncementBloc() : super(AnnouncementInitial()) {
    on<FetchAnnouncements>(_onFetchAnnouncements);
  }

  void _onFetchAnnouncements(
      FetchAnnouncements event, Emitter<AnnouncementState> emit) async {
    emit(AnnouncementLoading());
    try {
      // Simulate fetching data from an API or database
      await Future.delayed(const Duration(seconds: 2));
      final announcements = [
        Announcement(
          title: 'College Exam Announcement',
          description:
              'The final exams will be held from 1st December to 10th December. '
              'All students must submit their assignments by 25th November. '
              'The exam schedule will be posted on the notice board. '
              'Please ensure you have your ID cards with you during the exams.',
          date: '2023-11-01',
          time: '10:00 AM',
          user: 'Admin',
        ),
        Announcement(
          title: 'Holiday Announcement',
          description:
              'The college will remain closed from 24th December to 1st January for winter holidays. '
              'Classes will resume from 2nd January. '
              'Wishing everyone a happy holiday season!',
          date: '2023-12-01',
          time: '11:00 AM',
          user: 'Admin',
        ),
      ];
      emit(AnnouncementLoaded(announcements));
    } catch (e) {
      emit(AnnouncementError('Failed to fetch announcements'));
    }
  }
}
