import 'package:equatable/equatable.dart';

abstract class AnnouncementEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchAnnouncements extends AnnouncementEvent {}
