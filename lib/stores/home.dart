import 'package:mobx/mobx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../classes/Text.dart';

part 'home.g.dart';

class Home = _Home with _$Home;

abstract class _Home with Store {
  @observable
  List<Text> texts = [];

  FirebaseFirestore db = FirebaseFirestore.instance;

  @action
  Future<bool> getTexts() async {
    QuerySnapshot result = await db
        .collection('texts')
        .where('published', isEqualTo: true)
        .limit(35)
        .get();
    result.docs.forEach((element) {
      var data = element.data();
      //TODO - Tratar #
      Text text = new Text(
          data['userId'],
          data['title'],
          data['pages'],
          data['published'],
          data['ads'],
          data['adult'],
          data['hashtags'],
          data['alignment'],
          data['likes'],
          element.id,
          data['comments']);

      texts.add(text);
    });
    return true;
  }

  Future<Map> liked(String textId, String userId, int currentText) async {
    texts[currentText].liked(userId);
    //print(texts[currentText].getTitle());
    var result = await db
        .collection('texts')
        .doc(textId)
        .update({"likes": texts[currentText].getLikes()})
        .then((value) => 'success')
        .catchError((err) => err);
    if (result == 'success') {
      return {'error': '', "data": 'success'};
    } else {
      return {'error': result, "data": ''};
    }
  }

  Future<Map> addComment(String userId, int currentText, String comment) async {
    texts[currentText].comment(userId, comment);
    //print(texts[currentText].getTitle());
    var result = await db
        .collection('texts')
        .doc(texts[currentText].getTextId())
        .update({"comments": texts[currentText].getComments()})
        .then((value) => 'success')
        .catchError((err) => err);
    if (result == 'success') {
      return {'error': '', "data": 'success'};
    } else {
      return {'error': result, "data": ''};
    }
  }
}
