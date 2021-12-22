class Book {
  final String id;
  final String name;
  final String author;
  final String genre;
  final int copies;
  final String date;
  bool inWishlist;

  Book._(this.id, this.name, this.author, this.genre, this.copies, this.date,
      this.inWishlist);

  static Book fromDTO(BookDTO bookDTO) {
    return Book._(bookDTO.id, bookDTO.name, bookDTO.author, bookDTO.genre,
        bookDTO.copies, bookDTO.date, bookDTO.inWishlist);
  }
}

class BookDTO {
  final String id;
  final String name;
  final String author;
  final String genre;
  final int copies;
  final String date;
  final bool inWishlist;

  BookDTO._(this.id, this.name, this.author, this.genre, this.copies, this.date,
      this.inWishlist);

  static fromFirebase(
      {required String id,
      required bool inWishlist,
      required Map documentMap}) {
    return BookDTO._(
        id,
        documentMap["name"],
        documentMap["author"],
        documentMap["genre"],
        documentMap["copies"],
        documentMap["date"] ?? '',
        inWishlist);
  }
}
