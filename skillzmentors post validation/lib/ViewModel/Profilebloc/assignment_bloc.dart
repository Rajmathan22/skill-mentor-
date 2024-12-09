import 'package:bloc/bloc.dart';
import 'package:skillzmentors/Models/proflie_model/assignment_model.dart';
import 'assignment_event.dart';
import 'assignment_state.dart';

class AssignmentBloc extends Bloc<AssignmentEvent, AssignmentState> {
  AssignmentBloc() : super(AssignmentInitial()) {
    on<LoadAssignments>(_onLoadAssignments);
    on<SubmitAssignment>(_onSubmitAssignment);
  }

  void _onLoadAssignments(
      LoadAssignments event, Emitter<AssignmentState> emit) async {
    emit(AssignmentLoading());
    try {
      // Simulate fetching assignments from a data source
      await Future.delayed(const Duration(seconds: 1));
      final assignments = [
        Assignment(
          subject: 'Mathematics',
          topic: 'Surface Areas and Volumes',
          assignDate: '10 Nov 20',
          lastDate: '10 Dec 20',
        ),
        Assignment(
          subject: 'Science',
          topic: 'Structure of Atoms',
          assignDate: '10 Oct 20',
          lastDate: '30 Oct 20',
        ),
        Assignment(
          subject: 'English',
          topic: 'My Bestfriend Essay',
          assignDate: '10 Sep 20',
          lastDate: '30 Sep 20',
        ),
      ];
      emit(AssignmentLoaded(assignments));
    } catch (e) {
      emit(const AssignmentError('Failed to load assignments'));
    }
  }

  void _onSubmitAssignment(
      SubmitAssignment event, Emitter<AssignmentState> emit) async {
    // Handle assignment submission logic here
    // For now, just print the subject of the submitted assignment
    print('Assignment submitted for subject: ${event.subject}');
  }
}