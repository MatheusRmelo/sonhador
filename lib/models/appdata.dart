import 'package:flutter/material.dart';

class AppData with ChangeNotifier {
  List data = [];

  void setData(List newData) {
    data = newData;
    notifyListeners();
  }
}
