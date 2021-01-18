import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WriterData with ChangeNotifier {
  String title = 'Teste título';
  List texts = [];
  var db = FirebaseFirestore.instance;

  void saveText(String title, List pages) {
    db.collection('texts').add({"title": title, "pages": pages});
  }

  void updatePages(List pages) {
    db.collection('texts').doc('eHMTUteW9XItOr1vnHRl').update({"pages": pages});
  }

  void setTitle(String newTitle) {
    title = newTitle;
    notifyListeners();
  }
}
