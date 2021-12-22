import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/book_list_bloc.dart';
import 'package:flutter_app/bloc/events/book_list_event.dart';
import 'package:flutter_app/pages/widgets/book_list_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LibraryApp extends StatefulWidget {
  LibraryApp({Key? key}) : super(key: key);

  @override
  _LibraryAppState createState() => _LibraryAppState();
}

class _LibraryAppState extends State<LibraryApp> {
  @override
  void initState() {
    // Trig the first book list read from BE
    context.read<BookListBloc>().loadBooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Library App'),
      ),
      body: BlocBuilder<BookListBloc, BookListEvent>(builder: (context, event) {
        switch (event.runtimeType) {
          case LoadingBooksEvent:
            return BookListLoadingWidget();
          case LoadBooksErrorEvent:
            return BookListErrorWidget();
          case BooksLoadedEvent:
            BooksLoadedEvent e = event as BooksLoadedEvent;
            return BooksLoadedWidget(books: e.books);
          default:
            return BookIdleWidget();
        }
      }),
    );
  }
}
