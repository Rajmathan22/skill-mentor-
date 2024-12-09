import 'package:flutter/material.dart';
import 'package:skillzmentors/Components/AppBar/app_bar_withbackbutton.dart';
import 'dart:math';

import 'package:table_calendar/table_calendar.dart';

class AttendanceIndicator extends StatelessWidget {
  final double attendanceValue; // Value out of 100

  const AttendanceIndicator({
    super.key,
    required this.attendanceValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
            ),
            CustomPaint(
              size: const Size(100, 100),
              painter: CircularProgressPainter(
                progress: attendanceValue / 100, // Normalize value to 0-1
                color: Colors.blue,
              ),
            ),
            Text(
              '${attendanceValue.toStringAsFixed(1)}%',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Attendance Percentage : $attendanceValue%',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  final double progress; // Progress as a fraction (0.0 to 1.0)
  final Color color;

  CircularProgressPainter({
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint basePaint = Paint()
      ..strokeWidth = 10
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.stroke;

    final Paint progressPaint = Paint()
      ..strokeWidth = 10
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;

    // Draw base circle
    canvas.drawCircle(center, radius, basePaint);

    // Draw progress arc
    const double startAngle = -pi / 2; // Start from the top
    final double sweepAngle = 2 * pi * progress; // Arc angle based on progress
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

//info: attanance screen
class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithBackButton(),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF6FAAF5),
                  Color(0xFF9BCBF8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                const Text(
                  "CALENDAR",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "ATTENDANCE",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    TextButton(
                      onPressed: () {

                      },
                      child: const Text(
                        "HOLIDAY",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          //info: Calendar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TableCalendar(
              focusedDay: _focusedDay,
              firstDay: DateTime(2000),
              lastDay: DateTime(2100),
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.blueAccent,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                markerDecoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
            ),
          ),
          // Legend
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text("Absent"),
                    const Spacer(),
                    const Text("02"),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text("Festival & Holidays"),
                    const Spacer(),
                    const Text("01"),
                  ],
                ),
              ],
            ),
          ),
          // Holiday List
          // Expanded(
          //   child: Container(
          //     decoration: BoxDecoration(
          //       color: Colors.grey[100],
          //       borderRadius: BorderRadius.vertical(
          //         top: Radius.circular(30),
          //       ),
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.all(16.0),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             "List of Holidays",
          //             style: TextStyle(
          //               fontSize: 18,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //           SizedBox(height: 10),
          //           ListTile(
          //             title: Text("Diwali"),
          //             subtitle: Text("14th November"),
          //             trailing: Text("Saturday"),
          //           ),
          //           ListTile(
          //             title: Text("Govardhan Puja"),
          //             subtitle: Text("15th November"),
          //             trailing: Text("Sunday"),
          //           ),
          //           ListTile(
          //             title: Text("Bhaiya Dooj"),
          //             subtitle: Text("16th November"),
          //             trailing: Text("Monday"),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
