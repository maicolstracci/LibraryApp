import 'package:flutter_app/bloc/events/book_list_event.dart';
import 'package:flutter_app/bloc/filters/filters.dart';
import 'package:flutter_app/model/book.dart';
import 'package:flutter_app/services/firebase_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookListBloc extends Cubit<BookListEvent> {
  late FirebaseService _firebaseService;
  late List<Book> booksList;

  BookListBloc({required firebaseService}) : super(IdleBooksEvent()) {
    _firebaseService = firebaseService;
  }

  void addBookInWishlist(Book book) async {
    await _firebaseService.addBookToWishlist(book);

    booksList.firstWhere((element) => element == book).inWishlist = true;
    emit(BooksLoadedEvent(books: booksList));
  }

  void removeBookFromWishlist(Book book) async {
    await _firebaseService.removeBookFromWishlist(book);
    booksList.firstWhere((element) => element == book).inWishlist = false;
    emit(BooksLoadedEvent(books: booksList));
  }

  void filterBooks(BookFilter bookFilter) async {
    emit(LoadingBooksEvent());
    final filterTerm;

    switch (bookFilter.type) {
      case FilterType.name:
        filterTerm = ((bookFilter as NameFilter).name).toLowerCase();
        break;
    }

    List<Book> booksListFiltered = booksList
        .where((element) => element.name.toLowerCase().contains(filterTerm))
        .toList();

    emit(BooksLoadedEvent(books: booksListFiltered));
  }

  void loadBooks() async {
    emit(LoadingBooksEvent());

    List<BookDTO> booksDtos = await _firebaseService.loadBooksDocFromStorage();

    booksList =
        booksDtos.map<Book>((bookDTO) => Book.fromDTO(bookDTO)).toList();

    emit(BooksLoadedEvent(books: booksList));
  }
}
