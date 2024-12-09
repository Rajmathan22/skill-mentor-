import 'package:equatable/equatable.dart';
import 'package:skillzmentors/Models/proflie_model/report_model.dart';

abstract class UserReportEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SubmitUserReport extends UserReportEvent {
  final UserReport userReport;

  SubmitUserReport(this.userReport);

  @override
  List<Object> get props => [userReport];
}
