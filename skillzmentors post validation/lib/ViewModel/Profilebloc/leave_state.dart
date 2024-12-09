import 'package:equatable/equatable.dart';
import 'package:skillzmentors/Models/proflie_model/leave_model.dart';


abstract class LeaveState extends Equatable {
  const LeaveState();

  @override
  List<Object> get props => [];
}

class LeaveInitial extends LeaveState {}

class LeaveSubmitting extends LeaveState {}

class LeaveSubmitted extends LeaveState {
  final Leave leave;

  const LeaveSubmitted(this.leave);

  @override
  List<Object> get props => [leave];
}

class LeaveError extends LeaveState {
  final String message;

  const LeaveError(this.message);

  @override
  List<Object> get props => [message];
}