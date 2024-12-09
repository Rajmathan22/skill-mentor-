import 'package:equatable/equatable.dart';

abstract class AssignmentEvent extends Equatable {
  const AssignmentEvent();

  @override
  List<Object> get props => [];
}

class LoadAssignments extends AssignmentEvent {}

class SubmitAssignment extends AssignmentEvent {
  final String subject;

  const SubmitAssignment(this.subject);

  @override
  List<Object> get props => [subject];
}