import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sonhador/app/modules/writer/model/text_model.dart';
import '../model/writer_model.dart';

class WriterRepository {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<WriterModel> createNewText(String userName, String title,
      List<String> pages, String alignment) async {
    WriterModel textModel;

    DocumentReference result = await db.collection('texts').add({
      "title": title,
      "pages": pages,
      "alignment": alignment,
      "user_ame": userName
    });
    if (result.id != '') {
      textModel = WriterModel(
          id: result.id, title: title, pages: pages, alignment: alignment);
    }
    return textModel;
  }

  Future<WriterModel> getText(String id) async {
    WriterModel textModel;
    DocumentSnapshot result = await db.collection('texts').doc(id).get();
    if (result.id != '') {
      var data = result.data();
      textModel = WriterModel(
          id: result.id,
          title: data['title'],
          pages: data['pages'],
          alignment: data['alignment']);
    }
    return textModel;
  }

  Future<bool> editPages(String id, List pages) async {
    bool result = await db
        .collection('texts')
        .doc(id)
        .update({"pages": pages})
        .then((value) => true)
        .catchError((err) => false);

    return result;
  }

  Future<bool> changeAlignment(String id, String alignment) async {
    bool result = await db
        .collection('texts')
        .doc(id)
        .update({"alignment": alignment})
        .then((value) => true)
        .catchError((err) => false);

    return result;
  }

  Future<bool> changeTitle(String id, String title) async {
    bool result = await db
        .collection('texts')
        .doc(id)
        .update({"title": title})
        .then((value) => true)
        .catchError((err) => false);

    return result;
  }

  Future<String> getHashtags(String id) async {
    DocumentSnapshot result = await db.collection('texts').doc(id).get();
    String tags = "";
    if (result.id != '') {
      var data = result.data();
      if (data['hashtags'] != null) {
        for (var tag in data['hashtags']) {
          tags += '#' + tag;
        }
      }
    }
    return tags;
  }

  Future<bool> saveHashtags(String id, List<String> hashtags) async {
    bool result = await db
        .collection('texts')
        .doc(id)
        .update({"hashtags": hashtags})
        .then((value) => true)
        .catchError((err) => false);

    return result;
  }

  Future<bool> publishText(String id, bool ads, bool adult) async {
    bool result = await db
        .collection('texts')
        .doc(id)
        .update({
          "ads": ads,
          "published": true,
          "adult": adult,
          "comments": [],
          "likes": []
        })
        .then((value) => true)
        .catchError((err) => false);

    return result;
  }

  Future<List<TextModel>> getAllTexts(String userId) async {
    List<TextModel> list = [];

    QuerySnapshot result = await db
        .collection('texts')
        .where('userId', isEqualTo: userId)
        .limit(16)
        .get();

    result.docs.forEach((element) {
      var data = element.data();
      TextModel text = TextModel(data['title'], element.id);
      list.add(text);
    });

    return list;
  }

  Future<List<TextModel>> searchTexts(String userId, String textSearch) async {
    List<TextModel> list = [];

    QuerySnapshot result =
        await db.collection('texts').where('userId', isEqualTo: userId).get();

    result.docs.forEach((element) {
      var data = element.data();
      if (data['title'].toLowerCase().contains(textSearch)) {
        TextModel text = TextModel(data['title'], element.id);
        list.add(text);
      }
    });

    return list;
  }
}
