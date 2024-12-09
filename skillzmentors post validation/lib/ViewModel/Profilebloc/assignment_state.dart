import 'package:equatable/equatable.dart';
import 'package:skillzmentors/Models/proflie_model/assignment_model.dart';

abstract class AssignmentState extends Equatable {
  const AssignmentState();

  @override
  List<Object> get props => [];
}

class AssignmentInitial extends AssignmentState {}

class AssignmentLoading extends AssignmentState {}

class AssignmentLoaded extends AssignmentState {
  final List<Assignment> assignments;

  const AssignmentLoaded(this.assignments);

  @override
  List<Object> get props => [assignments];
}

class AssignmentError extends AssignmentState {
  final String message;

  const AssignmentError(this.message);

  @override
  List<Object> get props => [message];
}
