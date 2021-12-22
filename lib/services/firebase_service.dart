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

  Future<List<BookDTO>> loadBooksDocFromStorage() async {
    List<QueryDocumentSnapshot> bookQuery =
        (await _storage.orderBy("name").get()).docs;

    return bookQuery.map<BookDTO>((element) {
      Map<String, dynamic> documentMap = element.data() as Map<String, dynamic>;
      documentMap.addAll({'id': element.id});
      return BookDTO.fromFirebase(documentMap);
    }).toList();
  }
}
