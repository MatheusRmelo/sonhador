import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './models/appdata.dart';
import './models/writerdata.dart';

import 'pages/home.dart';
import 'pages/writer.dart';
import 'pages/search.dart';
import 'pages/publish.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AppData()),
      ChangeNotifierProvider(create: (context) => WriterData())
    ],
    child: App(),
  ));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: '/home', routes: {
      '/home': (context) => HomePage(),
      '/writer': (context) => WriterPage(),
      '/search': (context) => SearchPage(),
      '/publish': (context) => PublishPage(),
    });
  }
}
