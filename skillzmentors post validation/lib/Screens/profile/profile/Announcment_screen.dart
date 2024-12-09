import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillzmentors/Components/AppBar/app_bar_withbackbutton.dart';
import 'package:skillzmentors/ViewModel/Profilebloc/announcement_event.dart';
import 'package:skillzmentors/ViewModel/Profilebloc/announcement_state.dart';
import 'package:skillzmentors/ViewModel/Profilebloc/announcement_bloc.dart';

class AnnouncmentScreen extends StatelessWidget {
  const AnnouncmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AnnouncementBloc()..add(FetchAnnouncements()),
      child: Scaffold(
        appBar: const AppBarWithBackButton(),
        body: Stack(
          children: [
            // Background image
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/background1.png'), // Replace with your background image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Main content
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back icon and title
                    Row(
                      children: [
                        IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Announcements',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: "Times New Roman",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    // Announcements list
                    Expanded(
                      child: BlocBuilder<AnnouncementBloc, AnnouncementState>(
                        builder: (context, state) {
                          if (state is AnnouncementLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is AnnouncementLoaded) {
                            return ListView.builder(
                              itemCount: state.announcements.length,
                              itemBuilder: (context, index) {
                                final announcement = state.announcements[index];
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  elevation: 5,
                                  shadowColor: Colors.blue,
                                  color: Colors.white,
                                  child: ListTile(
                                    title: Text(
                                      announcement.title,
                                      style: const TextStyle(
                                        fontFamily: "Times New Roman",
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(announcement.description),
                                        const SizedBox(height: 10),
                                        Divider(
                                          color: Colors.black,
                                          thickness: 0.5,
                                        ),
                                        Text('Date: ${announcement.date}'),
                                        Text('Time: ${announcement.time}'),
                                        Text('Sent by: ${announcement.user}'),
                                      ],
                                    ),
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: Colors.white,
                                            title: Text(announcement.title),
                                            content: SingleChildScrollView(
                                              child: RichText(
                                                text: TextSpan(
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                  children: [
                                                    const TextSpan(
                                                        text: 'Description: '),
                                                    TextSpan(
                                                      text: announcement
                                                          .description,
                                                      style: const TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                    const TextSpan(
                                                        text:
                                                            '\n\nImportant Points:\n',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    TextSpan(
                                                      text:
                                                          '1. Final exams from 1st December to 10th December.\n',
                                                      style: const TextStyle(
                                                          color: Colors.blue),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          '2. Submit assignments by 25th November.\n',
                                                      style: const TextStyle(
                                                          color: Colors.blue),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          '3. Exam schedule on notice board.\n',
                                                      style: const TextStyle(
                                                          color: Colors.blue),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          '4. Carry ID cards during exams.',
                                                      style: const TextStyle(
                                                          color: Colors.blue),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Close'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          } else if (state is AnnouncementError) {
                            return Center(child: Text(state.message));
                          } else {
                            return const Center(
                                child: Text('No announcements available'));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Overlay image at the bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/vector.png', // Replace with your overlay image path
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height *
                    0.2, // Adjust height as needed
              ),
            ),
          ],
        ),
      ),
    );
  }
}
