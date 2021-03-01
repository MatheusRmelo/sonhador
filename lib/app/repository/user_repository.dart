import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sonhador/app/model/user_model.dart';
import 'package:sonhador/app/services/user_services.dart';

class UserRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final UserService service;

  UserRepository(this.service);

  Future<UserModel> signInWithGoogle() async {
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
      UserModel userModel;
      DocumentSnapshot result =
          await db.collection('users').doc(user.uid).get();
      if (result.exists) {
        var data = result.data();
        userModel =
            UserModel(result.id, data['display_name'], data['user_name']);
      } else {
        String userName = await createUser(user.uid, user.displayName);
        userModel = UserModel(user.uid, user.displayName, userName);
      }

      service.saveUser(userModel);
      return userModel;
    }

    return null;
  }

  Future<bool> existsUserName(String userName) async {
    QuerySnapshot result = await db
        .collection('users')
        .where('user_name', isEqualTo: userName)
        .get();
    if (result.docs.isEmpty) {
      return false;
    }
    return true;
  }

  Future<String> createUser(String userId, String displayName) async {
    var verifyExist = await db.collection('users').doc(userId).get();
    String userName;
    if (!verifyExist.exists) {
      String name = displayName.split(" ")[0];
      int iName = displayName.split(" ").length;
      String lastName = displayName.split(" ")[iName - 1];
      userName = (name + lastName).toLowerCase();

      var qtdUsers = await db
          .collection('users')
          .where('user_name', isEqualTo: userName)
          .get();
      if (qtdUsers.size != 0) {
        userName += qtdUsers.size.toString();
        bool exist = await existsUserName(userName);
        while (!exist) {
          Random random = Random();
          userName += random.nextInt(100).toString();
        }
      }
      await db
          .collection('users')
          .doc(userId)
          .set({"user_name": userName, "display_name": displayName});
    } else {
      userName = verifyExist.data()['user_name'];
    }

    print(userName);

    return userName;
  }

  Future<UserModel> signOutGoogle() async {
    await googleSignIn.signOut();

    UserModel user = await service.clearUser();

    return user;
  }

  void editUserName(String userId, String userName) async {
    QuerySnapshot result = await db
        .collection('users')
        .where('user_name', isEqualTo: userName)
        .get();
    if (result.docs.isEmpty) {
      await db.collection('users').doc(userId).update({"user_name": userName});
      service.saveUserName(userName);
    }
  }

  Future<String> getUserName(String userId) async {
    DocumentSnapshot result = await db.collection('users').doc(userId).get();

    return result.data()['user_name'];
  }
}
