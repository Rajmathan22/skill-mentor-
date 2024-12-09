import 'package:flutter/material.dart';

class GenderSelection extends StatefulWidget {
  final ValueChanged<String> onGenderSelected;

  const GenderSelection({super.key, required this.onGenderSelected});

  @override
  _GenderSelectionState createState() => _GenderSelectionState();
}

class _GenderSelectionState extends State<GenderSelection> {
  String? selectedGender;
  

  void _selectGender(String gender) {
    setState(() {
      selectedGender = gender;
    });
    widget.onGenderSelected(gender);
  }

  @override
  Widget build(BuildContext context) {
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _genderButton("Male", Icons.male),
        const SizedBox(width: 5),
        _genderButton("Female", Icons.female),
        const SizedBox(width: 5),
        _genderButton("Others", Icons.transgender),
      ],
    );
  }

  Widget _genderButton(String gender, IconData icon) {
    final isSelected = selectedGender == gender;
    return ElevatedButton.icon(
      onPressed: () => _selectGender(gender),
      icon: Icon(
        icon,
        color: isSelected ? Colors.white : Colors.blue,
      ),
      label: Text(
        gender,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.white,
        side: const BorderSide(color: Colors.blue),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
