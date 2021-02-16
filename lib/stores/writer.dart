import 'package:mobx/mobx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../classes/Text.dart';

part 'writer.g.dart';

class Writer = _Writer with _$Writer;

abstract class _Writer with Store {
  @observable
  List<Map> myTexts;
  @observable
  Text text;

  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  @action
  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User user = authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);

      print('signInWithGoogle succeeded: $user');

      return '$user';
    }

    return null;
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();

    print("User Signed Out");
  }

  @action
  createText({String userId, String newTitle = 'Sem título'}) async {
    text = new Text(userId, newTitle);

    var result = await db
        .collection('texts')
        .add(text.getText())
        .then((value) => value)
        .catchError((err) => err);

    if (result.id != null) {
      return {'error': '', "data": result.id};
    } else {
      return {'error': result, "data": ''};
    }
  }

  Future<Map> getTextById(String textId) async {
    var result = await db
        .collection('texts')
        .doc(textId)
        .get()
        .then((value) => value)
        .catchError((err) => err);
    if (result.id != null) {
      var data = result.data();
      text = new Text(
          'matheusRmelo',
          data['title'],
          data['pages'],
          data['published'],
          data['ads'],
          data['adult'],
          data['hashtags'],
          data['alignment']);
      return {'error': '', "data": data};
    } else {
      return {'error': result, "data": ''};
    }
  }

  Future<Map> updatePages(String textId) async {
    var result = await db
        .collection('texts')
        .doc(textId)
        .update({"pages": text.getPages()})
        .then((value) => 'success')
        .catchError((err) => err);
    if (result == 'success') {
      return {'error': '', "data": 'success'};
    } else {
      return {'error': result, "data": ''};
    }
  }

  Future<Map> updateTitle(String textId) async {
    var result = await db
        .collection('texts')
        .doc(textId)
        .update({"title": text.getTitle()})
        .then((value) => 'success')
        .catchError((err) => err);
    if (result == 'success') {
      return {'error': '', "data": 'success'};
    } else {
      return {'error': result, "data": ''};
    }
  }

  Future<Map> publishText(String textId) async {
    var result = await db
        .collection('texts')
        .doc(textId)
        .update(
            {"published": true, "ads": text.getAds(), "adult": text.getAdult()})
        .then((value) => 'success')
        .catchError((err) => err);
    if (result == 'success') {
      return {'error': '', "data": 'success'};
    } else {
      return {'error': result, "data": ''};
    }
  }

  Future<Map> saveHashTags(String textId) async {
    var result = await db
        .collection('texts')
        .doc(textId)
        .update({"hashtags": text.getHashtags()})
        .then((value) => 'success')
        .catchError((err) => err);
    if (result == 'success') {
      return {'error': '', "data": 'success'};
    } else {
      return {'error': result, "data": ''};
    }
  }

  Future<Map> saveAlignment(String textId) async {
    var result = await db
        .collection('texts')
        .doc(textId)
        .update({"alignment": text.getAlignment()})
        .then((value) => 'success')
        .catchError((err) => err);
    if (result == 'success') {
      return {'error': '', "data": 'success'};
    } else {
      return {'error': result, "data": ''};
    }
  }

  Future<bool> getMyTexts(String userId) async {
    List<Map> texts = [];
    QuerySnapshot result =
        await db.collection('texts').where('userId', isEqualTo: userId).get();
    result.docs.forEach((element) {
      texts.add({"text": element.data(), "id": element.id});
    });
    myTexts = texts;

    return true;
  }

  List<Map> searchText(textSearch) {
    List<Map> result = [];

    textSearch = textSearch.trim().toLowerCase();
    if (textSearch == '') {
      return result;
    }
    for (var text in myTexts) {
      if (text['text']['title'].toLowerCase().contains(textSearch)) {
        result.add(text);
      }
    }
    return result;
  }
}
