import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sonhador/app/utils/points.dart';

class PointsRepository {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference texts =
      FirebaseFirestore.instance.collection('texts');

  void score(String local, String textId, String userId, bool increment) async {
    db.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(texts.doc(textId));

      if (!snapshot.exists) {
        throw Exception('Texto não existe');
      }

      int newPoints = increment
          ? snapshot.data()['points'] + points[local]
          : snapshot.data()['points'] - points[local];

      transaction.update(texts.doc(textId), {"points": newPoints});

      return newPoints;
    });
    db.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(users.doc(userId));

      if (!snapshot.exists) {
        throw Exception('Usuário não existe');
      }

      int newPoints = increment
          ? snapshot.data()['points'] + points[local]
          : snapshot.data()['points'] - points[local];

      transaction.update(users.doc(userId), {"points": newPoints});

      return newPoints;
    });
  }
}
