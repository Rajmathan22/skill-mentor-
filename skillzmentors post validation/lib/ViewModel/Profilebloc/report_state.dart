import 'package:equatable/equatable.dart';

abstract class UserReportState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserReportInitial extends UserReportState {}

class UserReportSubmitting extends UserReportState {}

class UserReportSubmitted extends UserReportState {}

class UserReportError extends UserReportState {
  final String message;

  UserReportError(this.message);

  @override
  List<Object> get props => [message];
}
