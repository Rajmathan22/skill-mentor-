import 'package:equatable/equatable.dart';
import 'package:skillzmentors/Models/proflie_model/book_model.dart';

abstract class LibraryEvent extends Equatable {
  const LibraryEvent();

  @override
  List<Object> get props => [];
}

class LoadBooks extends LibraryEvent {}

class SelectBook extends LibraryEvent {
  final Book book;

  const SelectBook(this.book);

  @override
  List<Object> get props => [book];
}