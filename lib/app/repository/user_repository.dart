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
      String userName = await createUser(user.uid, user.displayName);
      UserModel userModel = UserModel(user.uid, user.displayName, userName);
      service.saveUser(userModel);
      return userModel;
    }

    return null;
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
      }
      await db.collection('users').doc(userId).set({"user_name": userName});
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
}
