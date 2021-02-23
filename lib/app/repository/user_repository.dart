import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sonhador/app/model/user_model.dart';

class UserRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseFirestore db = FirebaseFirestore.instance;

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
      UserModel userModel = UserModel(user.uid, user.displayName);
      createUser(user.uid, user.displayName);
      return userModel;
    }

    return null;
  }

  void createUser(String userId, String displayName) async {
    var verifyExist = await db.collection('users').doc(userId).get();
    if (!verifyExist.exists) {
      String name = displayName.split(" ")[0];
      int iName = displayName.split(" ").length;
      String lastName = displayName.split(" ")[iName - 1];
      String userName = (name + lastName).toLowerCase();

      var qtdUsers = await db
          .collection('users')
          .where('user_name', isEqualTo: userName)
          .get();
      if (qtdUsers.size != 0) {
        userName += qtdUsers.size.toString();
      }
      await db.collection('users').doc(userId).set({"user_name": userName});
    }
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();

    print("User Signed Out");
  }
}
