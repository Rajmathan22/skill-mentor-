import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillzmentors/Components/AppBar/app_bar_withbackbutton.dart';
import 'package:skillzmentors/Models/proflie_model/book_model.dart';
import 'package:skillzmentors/ViewModel/Profilebloc/library_bloc.dart';
import 'package:skillzmentors/ViewModel/Profilebloc/library_event.dart';
import 'package:skillzmentors/ViewModel/Profilebloc/library_state.dart';
import 'package:url_launcher/url_launcher.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Library',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: "Times New Roman",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  // Books list
                  Expanded(
                    child: BlocBuilder<LibraryBloc, LibraryState>(
                      builder: (context, state) {
                        if (state is LibraryLoading) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (state is LibraryLoaded) {
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: state.books.length,
                            itemBuilder: (context, index) {
                              final book = state.books[index];
                              return GestureDetector(
                                onTap: () {
                                  context
                                      .read<LibraryBloc>()
                                      .add(SelectBook(book));
                                },
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15.0),
                                      child: Image.network(
                                        book.imageUrl,
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      book.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Times New Roman",
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        } else if (state is BookSelected) {
                          return _buildBookDetails(context, state.book);
                        } else if (state is LibraryError) {
                          return Center(child: Text(state.message));
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookDetails(BuildContext context, Book book) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                context.read<LibraryBloc>().add(LoadBooks());
              },
            ),
            const SizedBox(width: 8),
            const Text(
              'Book Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: "Times New Roman",
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.network(
              book.imageUrl,
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 30),
        Text(
          'Name: ${book.name}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: "Times New Roman",
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Author: ${book.author}',
          style: const TextStyle(
            fontSize: 16,
            fontFamily: "Times New Roman",
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Details: ${book.details}',
          style: const TextStyle(
            fontSize: 16,
            fontFamily: "Times New Roman",
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            onPressed: () async {
              final String url =
                  book.downloadUrl; // Assuming book has a downloadUrl property
              final Uri uri = Uri.parse(url);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri);
              } else {
                throw 'Could not launch $url';
              }
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Ink(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF3354A8), Color(0xFF7891CA)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                alignment: Alignment.center,
                constraints: const BoxConstraints(
                  minWidth: 88,
                  minHeight: 36,
                ),
                child: const Text(
                  'Download',
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: "Times New Roman",
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
