import 'package:flutter_app/model/book.dart';

abstract class BookListEvent {}

class IdleBooksEvent extends BookListEvent {}

class LoadingBooksEvent extends BookListEvent {}

class LoadBooksErrorEvent extends BookListEvent {}

class BooksLoadedEvent extends BookListEvent {
  final List<Book> books;

  BooksLoadedEvent({required this.books});
}
