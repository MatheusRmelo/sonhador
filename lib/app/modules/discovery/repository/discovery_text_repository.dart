import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sonhador/app/modules/discovery/model/discovery_text_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:sonhador/app/modules/home/home_content/model/home_text_model.dart';

class DiscoveryTextRepository {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<HomeTextModel> getText(String textId) async {
    HomeTextModel text;

    DocumentSnapshot result = await db.collection('texts').doc(textId).get();
    var data = result.data();
    String photoUrl =
        await storage.ref("profiles/${data['userId']}.jpg").getDownloadURL();
    text = HomeTextModel(
        id: result.id,
        alignment: data['alignment'],
        comments: data['comments'],
        hashtags: data['hashtags'],
        likes: data['likes'],
        pages: data['pages'],
        title: data['title'],
        photoUrl: photoUrl,
        userId: data['userId']);

    return text;
  }

  void likedText(HomeTextModel text) async {
    await db.collection('texts').doc(text.id).update({"likes": text.likes});
  }

  void saveComment(HomeTextModel text) async {
    await db
        .collection('texts')
        .doc(text.id)
        .update({"comments": text.comments});
  }

  void likedComment(HomeTextModel text) async {
    await db
        .collection('texts')
        .doc(text.id)
        .update({"comments": text.comments});
  }
}
