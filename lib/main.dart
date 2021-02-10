import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './stores/writer.dart';

//import '../models/writerdata.dart';
import 'partials/homeappbar.dart';
import 'partials/writerappbar.dart';
import 'partials/loadingappbar.dart';
import 'partials/loading.dart';
import 'partials/customappbar.dart';
import 'partials/textbox.dart';

import './pages/placeholder.dart';
import './pages/no-user.dart';

part 'pages/home.dart';
part 'pages/home-screen.dart';

part 'pages/writer.dart';
part 'pages/writer-hashtag.dart';

part 'pages/publish.dart';
part 'pages/search.dart';

// import 'pages/search.dart';
// import 'pages/publish.dart';

final writer = Writer();
TextStyle smallText =
    TextStyle(fontFamily: 'Fredoka One', fontSize: 16, color: Colors.black);
TextStyle smallStyle = TextStyle(fontFamily: 'Fredoka One', fontSize: 12);
TextStyle smallStyleLight =
    TextStyle(fontFamily: 'Fredoka One', fontSize: 12, color: Colors.white);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: '/home', routes: {
      '/home': (context) => HomePage(),
      '/writer': (context) => WriterPage(),
      '/search': (context) => SearchPage(),
      '/publish': (context) => PublishPage(),
      '/hashtag': (context) => HashTagPage(),
    });
  }
}
