import 'package:flutter/material.dart';
import 'dart:io';

class NewPostState {
  final String text;
  final List<File> selectedImages;
  final String visibility;
  final double textFieldHeight;

  NewPostState({
    required this.text,
    required this.selectedImages,
    required this.visibility,
    required this.textFieldHeight,
  });

  NewPostState copyWith({
    String? text,
    List<File>? selectedImages,
    String? visibility,
    double? textFieldHeight,
  }) {
    return NewPostState(
      text: text ?? this.text,
      selectedImages: selectedImages ?? this.selectedImages,
      visibility: visibility ?? this.visibility,
      textFieldHeight: textFieldHeight ?? this.textFieldHeight,
    );
  }
}
