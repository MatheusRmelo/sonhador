import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sonhador/app/modules/writer/model/photo_model.dart';
import 'package:sonhador/app/modules/writer/model/text_model.dart';
import 'package:sonhador/app/utils/utils.dart';
import '../model/writer_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class WriterRepository {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  Future<WriterModel> createNewText(
      String userId, String title, List<String> pages, String alignment) async {
    WriterModel textModel;

    DocumentReference result = await db.collection('texts').add({
      "title": title,
      "pages": pages,
      "alignment": alignment,
      "userId": userId
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
    hashtags.remove("");
    bool result = await db
        .collection('texts')
        .doc(id)
        .update({"hashtags": hashtags})
        .then((value) => true)
        .catchError((err) => false);

    return result;
  }

  Future<bool> verifyPublish(String id) async {
    DocumentSnapshot result = await db.collection('texts').doc(id).get();
    return result.data()['published'];
  }

  Future<bool> savePhoto(String textId, File file) async {
    try {
      await storage.ref('texts/$textId.jpg').putFile(file);
      return true;
    } catch (e) {
      // e.g, e.code == 'canceled'
      return false;
    }
  }

  Future<PhotoModel> getPhoto(String textId) async {
    String photoUrl = await storage
        .ref('texts/$textId.jpg')
        .getDownloadURL()
        .catchError((err) => null);
    PhotoModel photoModel = PhotoModel(photoUrl, textId);
    return photoModel;
  }

  Future<bool> publishText(String id, bool ads, bool adult) async {
    bool result = await db
        .collection('texts')
        .doc(id)
        .update({
          //"ads": ads,
          "published": true,
          "adult": adult,
          "comments": [],
          "likes": [],
          "shared": [],
          "points": 0,
          "points_week": 0,
          "week_number": isoWeekNumber(DateTime.now())
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

    for (var element in result.docs) {
      var data = element.data();
      String photoUrl = await storage
          .ref("texts/${element.id}.jpg")
          .getDownloadURL()
          .catchError((err) => '');
      //String points = data['points'] ? data['points'] : '1';

      TextModel text =
          TextModel(data['title'], element.id, photoUrl, data['points']);
      list.add(text);
    }

    return list;
  }

  Future<List<TextModel>> searchTexts(String userId, String textSearch) async {
    List<TextModel> list = [];

    QuerySnapshot result =
        await db.collection('texts').where('userId', isEqualTo: userId).get();

    for (var element in result.docs) {
      var data = element.data();
      if (data['title'].toLowerCase().contains(textSearch)) {
        String photoUrl = await storage
            .ref("texts/${element.id}.jpg")
            .getDownloadURL()
            .catchError((err) => '');
        String points = data['points'] != null ? data['points'] : '';

        TextModel text = TextModel(data['title'], element.id, photoUrl, points);
        list.add(text);
      }
    }

    return list;
  }
}
