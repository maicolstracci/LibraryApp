import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/book_list_bloc.dart';
import 'package:flutter_app/bloc/events/book_list_event.dart';
import 'package:flutter_app/bloc/filters/filters.dart';
import 'package:flutter_app/pages/widgets/book_list_widgets.dart';
import 'package:flutter_app/pages/widgets/filter_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outline_search_bar/outline_search_bar.dart';

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
      body: SizedBox.expand(
        child: Column(
          children: [
            OutlineSearchBar(
              margin: EdgeInsets.all(16),
              onClearButtonPressed: (string) {
                context.read<BookListBloc>().loadBooks();
              },
              onKeywordChanged: (string) {
                context.read<BookListBloc>().filterBooks(
                    NameFilter(name: string, type: FilterType.name));
              },
              onSearchButtonPressed: (string) {
                context.read<BookListBloc>().filterBooks(
                    NameFilter(name: string, type: FilterType.name));
              },
            ),
            Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Filtro:",
                        style: TextStyle(fontSize: 18),
                      ),
                      FilterButton(isActive: false, text: "text"),
                      TextButton(
                          onPressed: () {}, child: Text("Gia' presi prestito")),
                      TextButton(onPressed: () {}, child: Text("Wishlist"))
                    ],
                  ),
                )),
            Expanded(
              flex: 8,
              child: BlocBuilder<BookListBloc, BookListEvent>(
                  builder: (context, event) {
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
            ),
          ],
        ),
      ),
    );
  }
}
