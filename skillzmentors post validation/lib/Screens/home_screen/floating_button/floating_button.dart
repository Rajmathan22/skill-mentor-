import 'package:flutter/material.dart';
import 'package:skillzmentors/config/Colors/colors.dart';
class FloatingButton extends StatelessWidget {
  const FloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.selectedItem,
      shape: const CircleBorder(),
      onPressed: () {
        // Handle button press action
      },
      child: const Icon(
        Icons.calendar_month,
        color: AppColors.white,
      ),
    );
  }
}
