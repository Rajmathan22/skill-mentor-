import 'package:flutter/material.dart';

@immutable
abstract class PostEvent {}

class PostInitialEvent extends PostEvent {}

class PickImagesEvent extends PostEvent {}

class TogglePrivacyEvent extends PostEvent {
  final bool isPrivate;

  TogglePrivacyEvent({required this.isPrivate});
}

class UpdateDescriptionEvent extends PostEvent {
  final String description;

  UpdateDescriptionEvent(this.description);
}

class UploadDataEvent extends PostEvent {}
