import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/book_list_bloc.dart';
import 'package:flutter_app/services/firebase_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pages/library_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Startup initializations
  FirebaseService firebaseService = await FirebaseService.init();
  //
  runApp(MyApp(firebaseService: firebaseService));
}

class MyApp extends StatelessWidget {
  final FirebaseService firebaseService;

  MyApp({required this.firebaseService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
          create: (_) => BookListBloc(firebaseService: firebaseService),
          child: LibraryApp()),
    );
  }
}
