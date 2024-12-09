import 'package:bloc/bloc.dart';
import 'package:skillzmentors/Models/proflie_model/book_model.dart';
import 'library_event.dart';
import 'library_state.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  LibraryBloc() : super(LibraryInitial()) {
    on<LoadBooks>(_onLoadBooks);
    on<SelectBook>(_onSelectBook);
  }

  void _onLoadBooks(LoadBooks event, Emitter<LibraryState> emit) async {
    emit(LibraryLoading());
    try {
      // Simulate fetching books from a data source
      await Future.delayed(const Duration(seconds: 1));
      final books = List.generate(
        15,
        (index) => Book(
          name: 'Engineering Book $index',
          imageUrl:
              'https://i.ibb.co/DMgnCtY/81-YZo-MIIKUL-AC-UF1000-1000-QL80.jpg',
          author: 'Author $index',
          details: 'Details about Engineering Book $index',
          downloadUrl:
              'https://drive.google.com/uc?export=download&id=1J3i6BBMagXVjuyiVJnHAZeCdGbddpvSh',
        ),
      );
      emit(LibraryLoaded(books));
    } catch (e) {
      emit(const LibraryError('Failed to load books'));
    }
  }

  void _onSelectBook(SelectBook event, Emitter<LibraryState> emit) {
    emit(BookSelected(event.book));
  }
}
