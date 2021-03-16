import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sonhador/app/modules/notification/model/notification_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class NotificationRepository {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<List<NotificationModel>> getNotifications(String userId) async {
    List<NotificationModel> list = [];
    DocumentSnapshot result = await db.collection('users').doc(userId).get();

    var data = result.data();
    for (Map element in data['notifications']) {
      String photoUrl = await storage
          .ref('profiles/${element['userId']}.jpg')
          .getDownloadURL()
          .catchError((err) => null);
      NotificationModel notification =
          NotificationModel(element['message'], element['userId'], photoUrl);
      list.add(notification);
    }
    return list;
  }
}
