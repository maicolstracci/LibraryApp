import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/book_list_bloc.dart';
import 'package:flutter_app/model/book.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookListLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 80,
            width: 80,
            child: CircularProgressIndicator(),
          ),
          Text(
            "We are loading the book list!",
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}

class BookListErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 80,
            width: 80,
            child: Icon(
              Icons.error,
              color: Colors.red,
            ),
          ),
          Text(
            "Ops! Something went wrong...",
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}

class BookIdleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Waiting on your next move ser!",
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

class BooksLoadedWidget extends StatelessWidget {
  final List<Book> books;

  const BooksLoadedWidget({Key? key, required this.books}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => GestureDetector(
        onTap: () => {},
        child: Card(
          color: Colors.blueAccent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      books[index].name,
                      style: TextStyle(fontSize: 28),
                    ),
                    IconButton(
                        onPressed: () {
                          final bloc = context.read<BookListBloc>();
                          books[index].inWishlist
                              ? bloc.removeBookFromWishlist(books[index])
                              : bloc.addBookInWishlist(books[index]);
                        },
                        icon: Icon(
                          books[index].inWishlist
                              ? Icons.star
                              : Icons.star_border_outlined,
                          color: Colors.yellow,
                        ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      books[index].author,
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      books[index].genre,
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Copies left: " + books[index].copies.toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      itemCount: books.length,
    );
  }
}
