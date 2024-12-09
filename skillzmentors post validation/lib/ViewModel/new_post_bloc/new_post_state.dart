import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

@immutable
abstract class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<XFile> selectedImages;
  final String description;
  final bool isPrivate;

  PostLoaded({
    required this.selectedImages,
    required this.description,
    required this.isPrivate,
  });
}

class PostError extends PostState {
  final String message;

  PostError(this.message);
}

class PostUploadedSuccessfully extends PostState {}
