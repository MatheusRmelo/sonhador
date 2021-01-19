import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WriterData with ChangeNotifier {
  String title = 'Teste título';
  List texts = [];
  var db = FirebaseFirestore.instance;

  Future<Map> saveText(String title, List pages) async {
    var result = await db
        .collection('texts')
        .add({"title": title, "pages": pages}).then((value) => value);
    return {'error': '', "data": result.id};
  }

  void updatePages(List pages, @required String textId) {
    db.collection('texts').doc(textId).update({"pages": pages});
  }

  Future<Map> getText(@required String textId) async {
    DocumentSnapshot result = await db.collection('texts').doc(textId).get();

    return {"error": '', "data": result.data()};
  }

  void setTitle({String newTitle, bool update = false, String textId = ''}) {
    title = newTitle;
    if (update) {
      db.collection('texts').doc(textId).update({"title": newTitle});
    }

    notifyListeners();
  }
}
