import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './models/appdata.dart';
import './models/writerdata.dart';

import 'pages/home.dart';
import 'pages/writer.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppData()),
        ChangeNotifierProvider(create: (context) => WriterData())
      ],
      child: App(),
    ));

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: '/home', routes: {
      '/home': (context) => HomePage(),
      '/writer': (context) => WriterPage(),
    });
  }
}
