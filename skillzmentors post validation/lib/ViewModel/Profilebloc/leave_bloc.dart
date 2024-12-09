import 'package:bloc/bloc.dart';
import 'leave_event.dart';
import 'leave_state.dart';

class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  LeaveBloc() : super(LeaveInitial()) {
    on<SubmitLeave>(_onSubmitLeave);
  }

  void _onSubmitLeave(SubmitLeave event, Emitter<LeaveState> emit) async {
    emit(LeaveSubmitting());
    try {
      // Simulate a delay for submitting the leave
      await Future.delayed(const Duration(seconds: 2));
      emit(LeaveSubmitted(event.leave));
    } catch (e) {
      emit(const LeaveError('Failed to submit leave'));
    }
  }
}
