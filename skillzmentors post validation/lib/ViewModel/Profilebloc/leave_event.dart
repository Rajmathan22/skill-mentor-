import 'package:equatable/equatable.dart';
import 'package:skillzmentors/Models/proflie_model/leave_model.dart';

abstract class LeaveEvent extends Equatable {
  const LeaveEvent();

  @override
  List<Object> get props => [];
}

class SubmitLeave extends LeaveEvent {
  final Leave leave;

  const SubmitLeave(this.leave);

  @override
  List<Object> get props => [leave];
}
