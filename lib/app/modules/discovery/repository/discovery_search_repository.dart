import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sonhador/app/modules/discovery/model/discovery_text_model.dart';
import 'package:sonhador/app/modules/discovery/model/discovery_user_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class DiscoverySearchRepository {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<List<DiscoveryTextModel>> searchTexts(String textSearch) async {
    List<DiscoveryTextModel> list = [];

    QuerySnapshot result =
        await db.collection('texts').where('published', isEqualTo: true).get();
    if (textSearch == '') {
      return list;
    }
    for (var element in result.docs) {
      var data = element.data();
      if (data['title'].toLowerCase().contains(textSearch)) {
        String photoUrl = await storage
            .ref("profiles/${element.id}.jpg")
            .getDownloadURL()
            .catchError((err) => '');
        DiscoveryTextModel text = DiscoveryTextModel(
            data['title'], element.id, data['points'], photoUrl);
        list.add(text);
      }
    }

    return list;
  }

  Future<List<DiscoveryUserModel>> searchUsers(String textSearch) async {
    List<DiscoveryUserModel> list = [];

    QuerySnapshot result = await db.collection('users').get();
    if (textSearch == '') {
      return list;
    }
    for (var element in result.docs) {
      var data = element.data();
      if (data['display_name'].toLowerCase().contains(textSearch) ||
          data['user_name'].toLowerCase().contains(textSearch)) {
        String photoUrl = await storage
            .ref("profiles/${element.id}.jpg")
            .getDownloadURL()
            .catchError((err) => '');
        DiscoveryUserModel user = DiscoveryUserModel(
            userId: element.id,
            photo: photoUrl,
            points: data['points'],
            userName: data['user_name']);
        list.add(user);
      }
    }

    return list;
  }
}
