// errors.dart
import 'package:flutter/material.dart';

void handleApiError(String message, BuildContext? context) {
  print('API Error: $message');
  if (context != null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

void handleException(String message, {BuildContext? context}) {
  print('Exception: $message');
  if (context != null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Something went wrong: $message')),
    );
  }
}
