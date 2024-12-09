import 'package:bloc/bloc.dart';
import 'package:skillzmentors/ViewModel/Profilebloc/report_event.dart';
import 'package:skillzmentors/ViewModel/Profilebloc/report_state.dart';


class UserReportBloc extends Bloc<UserReportEvent, UserReportState> {
  UserReportBloc() : super(UserReportInitial()) {
    on<SubmitUserReport>(_onSubmitUserReport);
  }

  void _onSubmitUserReport(
      SubmitUserReport event, Emitter<UserReportState> emit) async {
    emit(UserReportSubmitting());
    try {
      // Simulate a network call
      await Future.delayed(const Duration(seconds: 2));
      emit(UserReportSubmitted());
    } catch (e) {
      emit(UserReportError('Failed to submit report'));
    }
  }
}