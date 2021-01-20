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

  List<Map> searchText(textSearch) {
    List<Map> result = [];

    textSearch = textSearch.trim().toLowerCase();
    if (textSearch == '') {
      return result;
    }

    for (var text in texts) {
      if (text['text']['title'].toLowerCase().contains(textSearch)) {
        result.add(text);
      }
    }
    return result;
  }

  void getMyTexts({String userId, bool published = false}) async {
    List<Map> texts = [];
    QuerySnapshot result =
        await db.collection('texts').where('userId', isEqualTo: userId).get();

    result.docs.forEach((element) {
      if (element.data()['published'] == published) {
        texts.add({"text": element.data(), "id": element.id});
      }
    });
    setTexts(newTexts: texts);
  }

  void updatePages(List pages, @required String textId) {
    db.collection('texts').doc(textId).update({"pages": pages});
  }

  Future<Map> getText(@required String textId) async {
    DocumentSnapshot result = await db.collection('texts').doc(textId).get();

    return {"error": '', "data": result.data()};
  }

  void setTexts({List<Map> newTexts}) {
    texts = newTexts;
    notifyListeners();
  }

  void setTitle({String newTitle, bool update = false, String textId = ''}) {
    title = newTitle;
    if (update) {
      db.collection('texts').doc(textId).update({"title": newTitle});
    }

    notifyListeners();
  }
}
