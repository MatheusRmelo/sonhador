import 'package:flutter/material.dart';

import 'pages/home.dart';
import 'pages/writer.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: '/home', routes: {
      '/home': (context) => HomePage(),
      '/writer': (context) => WriterPage(),
    });
  }
}
