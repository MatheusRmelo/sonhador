import 'package:flutter/material.dart';

class WriterData with ChangeNotifier {
  String title = '';

  void setTitle(String newTitle) {
    title = newTitle;
    notifyListeners();
  }
}
