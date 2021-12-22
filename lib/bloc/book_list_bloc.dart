import 'package:flutter_app/bloc/events/book_list_event.dart';
import 'package:flutter_app/model/book.dart';
import 'package:flutter_app/services/firebase_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookListBloc extends Cubit<BookListEvent> {
  late FirebaseService _firebaseService;

  BookListBloc({required firebaseService}) : super(IdleBooksEvent()) {
    _firebaseService = firebaseService;
  }

  void loadBooks() async {
    emit(LoadingBooksEvent());

    List<BookDTO> booksDtos = await _firebaseService.loadBooksDocFromStorage();

    List<Book> booksList =
        booksDtos.map<Book>((bookDTO) => Book.fromDTO(bookDTO)).toList();

    emit(BooksLoadedEvent(books: booksList));
  }
}
