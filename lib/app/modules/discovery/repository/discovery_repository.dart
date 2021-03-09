import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sonhador/app/modules/discovery/model/discovery_text_model.dart';
import 'package:sonhador/app/modules/discovery/model/discovery_user_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class DiscoveryRepository {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<List<DiscoveryTextModel>> getTopTexts() async {
    List<DiscoveryTextModel> list = [];

    QuerySnapshot result = await db
        .collection('texts')
        .orderBy('points', descending: true)
        .limit(10)
        .get();

    result.docs.forEach((element) {
      var data = element.data();
      DiscoveryTextModel text =
          DiscoveryTextModel(data['title'], element.id, data['points']);
      if (data['published']) {
        list.add(text);
      }
    });

    return list;
  }

  Future<List<DiscoveryUserModel>> getTopUsers() async {
    List<DiscoveryUserModel> list = [];

    QuerySnapshot result = await db
        .collection('users')
        .orderBy('points', descending: true)
        .limit(10)
        .get();

    for (var element in result.docs) {
      var data = element.data();
      String photoUrl =
          await storage.ref("profiles/${element.id}.jpg").getDownloadURL();
      DiscoveryUserModel user = DiscoveryUserModel(
          userId: element.id,
          userName: data['user_name'],
          points: data['points'],
          photo: photoUrl);
      list.add(user);
    }

    return list;
  }
}
