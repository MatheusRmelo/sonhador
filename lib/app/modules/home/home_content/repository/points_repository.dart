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
      int newPointsWeek = increment
          ? snapshot.data()['points_week'] + points[local]
          : snapshot.data()['points_week'] - points[local];
      int weekNumber = snapshot.data()['week_number'];

      int dayOfYear(DateTime date) {
        return date.difference(DateTime(date.year, 1, 1)).inDays;
      }

      int isoWeekNumber(DateTime date) {
        int daysToAdd = DateTime.thursday - date.weekday;
        DateTime thursdayDate = daysToAdd > 0
            ? date.add(Duration(days: daysToAdd))
            : date.subtract(Duration(days: daysToAdd.abs()));
        int dayOfYearThursday = dayOfYear(thursdayDate);
        return 1 + ((dayOfYearThursday - 1) / 7).floor();
      }

      if (isoWeekNumber(DateTime.now()) != weekNumber) {
        weekNumber = isoWeekNumber(DateTime.now());
        newPointsWeek = 0;
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

      transaction.update(users.doc(userId), {"points": newPoints});

      return newPoints;
    });
  }
}
