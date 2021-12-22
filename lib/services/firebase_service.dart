import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app/model/book.dart';

class FirebaseService {
  late CollectionReference _myBooks;
  late CollectionReference _storage;
  late CollectionReference _wishlist;

  FirebaseService._init() {
    _myBooks = FirebaseFirestore.instance.collection("tbl_my_books");
    _storage = FirebaseFirestore.instance.collection("tbl_storage");
    _wishlist = FirebaseFirestore.instance.collection("tbl_wishlist");
  }

  static Future<FirebaseService> init() async {
    await Firebase.initializeApp();
    return FirebaseService._init();
  }

  Future addBookToWishlist(Book book) async {
    await _wishlist.add({"id": book.id, "name": book.name});
  }

  Future removeBookFromWishlist(Book book) async {
    List<QueryDocumentSnapshot> bookQuery = (await _wishlist.get()).docs;

    await _wishlist
        .doc(bookQuery.firstWhere((element) => element.get("id") == book.id).id)
        .delete();
  }

  Future<List<String>> loadWishlistBooksIds() async {
    List<QueryDocumentSnapshot> bookQuery = (await _wishlist.get()).docs;
    return bookQuery.map<String>((element) {
      return (Map<String, String>.from(element.data() as Map))["id"] as String;
    }).toList();
  }

  Future<List<BookDTO>> loadBooksDocFromStorage() async {
    final bookWishlistIds = await loadWishlistBooksIds();

    List<QueryDocumentSnapshot> bookQuery =
        (await _storage.orderBy("name").get()).docs;

    return bookQuery.map<BookDTO>((element) {
      Map<String, dynamic> documentMap = element.data() as Map<String, dynamic>;
      return BookDTO.fromFirebase(
          id: element.id,
          documentMap: documentMap,
          inWishlist: bookWishlistIds.contains(element.id));
    }).toList();
  }
}
