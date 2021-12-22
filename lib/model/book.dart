class Book {
  final String id;
  final String name;
  final String author;
  final String genre;
  final int copies;
  final String date;

  Book._(this.id, this.name, this.author, this.genre, this.copies, this.date);

  static Book fromDTO(BookDTO bookDTO) {
    return Book._(bookDTO.id, bookDTO.name, bookDTO.author, bookDTO.genre,
        bookDTO.copies, bookDTO.date);
  }
}

class BookDTO {
  final String id;
  final String name;
  final String author;
  final String genre;
  final int copies;
  final String date;

  BookDTO._(
      this.id, this.name, this.author, this.genre, this.copies, this.date);

  static fromFirebase(Map data) {
    return BookDTO._(data["id"], data["name"], data["author"], data["genre"],
        data["copies"], data["date"] ?? '');
  }
}
