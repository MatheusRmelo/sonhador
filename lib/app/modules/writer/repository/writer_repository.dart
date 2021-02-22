import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sonhador/app/modules/writer/model/text_model.dart';
import '../model/writer_model.dart';

class WriterRepository {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<WriterModel> createNewText(
      String title, List<String> pages, String alignment) async {
    WriterModel textModel;

    DocumentReference result = await db.collection('texts').add({
      "title": title,
      "pages": pages,
      "alignment": alignment,
      "userId": 'matheusRmelo'
    });
    if (result.id != '') {
      textModel = WriterModel(
          id: result.id, title: title, pages: pages, alignment: alignment);
    }
    return textModel;
  }

  Future<bool> editPages(String id, List<String> pages) async {
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
        .update({"ads": ads, "published": true, "adult": adult})
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
}
