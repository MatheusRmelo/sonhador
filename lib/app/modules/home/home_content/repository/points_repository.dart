import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sonhador/app/utils/points.dart';
import 'package:sonhador/app/utils/utils.dart';

class PointsRepository {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference texts =
      FirebaseFirestore.instance.collection('texts');

  void score(String local, String textId, String userId, bool increment) async {
    int weekNumber = isoWeekNumber(DateTime.now());
    QuerySnapshot resultOldWeeks = await db
        .collection('texts')
        .where('week_number', isNotEqualTo: weekNumber)
        .get();
    if (resultOldWeeks.docs.isNotEmpty) {
      for (var element in resultOldWeeks.docs) {
        await db
            .collection('texts')
            .doc(element.id)
            .update({"week_number": weekNumber, "points_week": 0});
      }
    }
    QuerySnapshot resultOldUsers = await db
        .collection('users')
        .where('week_number', isNotEqualTo: weekNumber)
        .get();
    if (resultOldUsers.docs.isNotEmpty) {
      for (var element in resultOldUsers.docs) {
        await db
            .collection('users')
            .doc(element.id)
            .update({"week_number": weekNumber, "points_week": 0});
      }
    }

    db.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(texts.doc(textId));

      if (!snapshot.exists) {
        throw Exception('Texto não existe');
      }

      int newPoints = increment
          ? snapshot.data()['points'] + points[local]
          : snapshot.data()['points'] - points[local];
      int newPointsWeek = increment
          ? snapshot.data()['points_week'] + points[local]
          : snapshot.data()['points_week'] - points[local];
      int weekNumber = snapshot.data()['week_number'];

      if (isoWeekNumber(DateTime.now()) != weekNumber) {
        weekNumber = isoWeekNumber(DateTime.now());
        newPointsWeek = increment ? points[local] : 0;
      }

      transaction.update(texts.doc(textId), {
        "points": newPoints,
        "week_number": weekNumber,
        "points_week": newPointsWeek
      });

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

      int newPointsWeek = increment
          ? snapshot.data()['points_week'] + points[local]
          : snapshot.data()['points_week'] - points[local];
      int weekNumber = snapshot.data()['week_number'];

      if (isoWeekNumber(DateTime.now()) != weekNumber) {
        weekNumber = isoWeekNumber(DateTime.now());
        newPointsWeek = increment ? points[local] : 0;
      }

      transaction.update(users.doc(userId), {
        "points": newPoints,
        "week_number": weekNumber,
        "points_week": newPointsWeek
      });

      return newPoints;
    });
  }
}
