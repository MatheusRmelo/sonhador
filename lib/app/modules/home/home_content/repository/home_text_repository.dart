import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sonhador/app/modules/home/home_content/model/home_text_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class HomeTextRepository {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<List<HomeTextModel>> getTexts() async {
    List<HomeTextModel> texts = [];

    QuerySnapshot result = await db
        .collection('texts')
        .where('published', isEqualTo: true)
        .limit(10)
        .get();

    for (var element in result.docs) {
      var data = element.data();

      String photoUrl = await storage
          .ref("profiles/${data['userId']}.jpg")
          .getDownloadURL()
          .catchError((err) => null);
      List comments = data['comments'];
      for (var element in comments) {
        DocumentSnapshot results =
            await db.collection('users').doc(element['user_id']).get();
        if (results.exists) {
          element['user_name'] = results.data()['user_name'];
        }
      }

      HomeTextModel text = HomeTextModel(
          id: element.id,
          alignment: data['alignment'],
          likes: data['likes'],
          shared: data['shared'],
          pages: data['pages'],
          title: data['title'],
          comments: comments,
          hashtags: data['hashtags'],
          userId: data['userId'],
          photoUrl: photoUrl);
      texts.add(text);
    }

    return texts;
  }

  Future<List<HomeTextModel>> getMoreTexts(String lastId) async {
    List<HomeTextModel> texts = [];

    DocumentSnapshot last = await db.collection('texts').doc(lastId).get();
    QuerySnapshot result = await db
        .collection('texts')
        .where('published', isEqualTo: true)
        .startAfterDocument(last)
        .limit(10)
        .get();
    //print(last.id);
    for (var element in result.docs) {
      var data = element.data();

      String photoUrl =
          await storage.ref("profiles/${data['userId']}.jpg").getDownloadURL();
      List comments = data['comments'];
      comments.forEach((element) async {
        DocumentSnapshot results =
            await db.collection('users').doc(element['user_id']).get();
        if (results.exists) {
          element['user_name'] = results.data()['user_name'];
        }
      });
      //print(comments);
      HomeTextModel text = HomeTextModel(
          id: element.id,
          alignment: data['alignment'],
          likes: data['likes'],
          pages: data['pages'],
          title: data['title'],
          comments: comments,
          hashtags: data['hashtags'],
          userId: data['userId'],
          photoUrl: photoUrl);
      texts.add(text);
    }

    return texts;
  }

  void likedText(HomeTextModel text) async {
    await db.collection('texts').doc(text.id).update({"likes": text.likes});
  }

  void sharedText(HomeTextModel text) async {
    await db.collection('texts').doc(text.id).update({"shared": text.shared});
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
