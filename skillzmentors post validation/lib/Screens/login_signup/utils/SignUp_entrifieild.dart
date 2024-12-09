import 'package:flutter/material.dart';

class entryField extends StatefulWidget {
  final String? initialValue;
  final String title;
  final IconData? iconData;
  final TextEditingController? controller;
  final dynamic onSendTap;

  const entryField({
    super.key,
    this.initialValue,
    required this.title,
    this.iconData,
    this.controller,
    this.onSendTap,
  });

  @override
  State<entryField> createState() => _EntryFieldState();
}

class _EntryFieldState extends State<entryField> {
  bool isSendClicked = false;
  bool isverified = false;

  void handleSendButtonClick() {
    setState(() {
      isSendClicked = true;
      print('otp sent');
    });
  }

  void handleverifyButtonClick() {
    setState(() {
      isverified = true;
      print('verified');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            fontSize: 16,
            fontFamily: 'Times New Roman',
            fontWeight: FontWeight.bold,
            color: Colors.black, // White color for headings
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          initialValue: widget.controller == null ? widget.initialValue : null,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black, // Dark Gray for field text
          ),
          decoration: InputDecoration(
            hintText: widget.title == 'First Name'
                ? 'Enter First Name'
                : widget.title == 'Last Name'
                    ? 'Enter Last Name'
                    : widget.title == 'Phone Number'
                        ? 'Enter Your Phone Number'
                        : widget.title == 'Roll Number'
                            ? 'Enter Your Roll Number'
                            : widget.title == 'Staff ID'
                                ? 'Enter Your Staff ID'
                                : widget.title == 'College Name'
                                    ? 'Enter Your College Name'
                                    : widget.title == 'Confirm Password'
                                        ? 'Re-Enter the Password'
                                        : widget.title == 'OTP'
                                            ? 'OTP'
                                            : widget.title == 'Gender'
                                                ? 'Enter your Gender'
                                                : widget.title == 'Year'
                                                    ? 'Enter your College Year'
                                                    : widget.title ==
                                                            'Degree and Course'
                                                        ? 'Enter your Degree and Course'
                                                        : widget.title ==
                                                                'Email'
                                                            ? 'Enter your email address'
                                                            : 'Enter the Password',
            hintStyle: const TextStyle(
                fontFamily: 'Times New Roman', color: Colors.grey),
            filled: true,
            fillColor: Colors.white, // Light Gray for input field background
            contentPadding: const EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 20.0,
            ),
            prefixIcon: widget.iconData != null
                ? Icon(
                    widget.iconData,
                    color: Colors.blue, // Bright Aqua for icons
                    size: 28,
                  )
                : null,
            suffixIcon: widget.title == 'OTP'
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.blue, // Bright Aqua for button background
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: isverified
                        ? const Icon(
                            Icons.check,
                            color: Colors.green,
                            size: 28,
                            shadows: [
                              Shadow(
                                blurRadius: 2.0,
                                color: Colors.greenAccent,
                              )
                            ],
                          )
                        : TextButton(
                            onPressed: isSendClicked
                                ? handleverifyButtonClick
                                : handleSendButtonClick,
                            child: Text(
                              isSendClicked ? 'Verify' : 'Send',
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'Times New Roman',
                                fontWeight: FontWeight.bold,
                                fontSize: 19,
                              ),
                            ),
                          ),
                  )
                : null,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: Colors.blue),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                  color: Colors.blue), // Bright Aqua for focused border
            ),
          ),
          obscureText: widget.title == 'Password',
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
