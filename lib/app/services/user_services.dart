import 'package:shared_preferences/shared_preferences.dart';
import 'package:sonhador/app/model/user_model.dart';

class UserService {
  Future<UserModel> verifyUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString('user_name');
    String displayName = prefs.getString('display_name');
    String userId = prefs.getString('user_id');
    List<String> followers = prefs.getStringList('followers');
    List<String> following = prefs.getStringList('following');

    if (userId == null) {
      userId = '';
      userName = '';
      displayName = '';
      following = [];
      followers = [];
    }

    UserModel user = UserModel(
        userId: userId,
        displayName: displayName,
        userName: userName,
        followers: followers,
        following: following);

    return user;
  }

  void saveUser(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('user_name', user.userName);
    await prefs.setString('display_name', user.displayName);
    await prefs.setString('user_id', user.userId);
    await prefs.setStringList('followers', user.followers);
    await prefs.setStringList('following', user.following);
  }

  void saveUserName(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('user_name', userName);
  }

  void newFollow(String otherId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> following = prefs.getStringList('following');
    following.add(otherId);

    await prefs.setStringList('following', following);
  }

  Future<UserModel> clearUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', '');
    await prefs.setString('display_name', '');
    await prefs.setString('user_id', '');
    await prefs.setStringList('followers', []);
    await prefs.setStringList('following', []);

    UserModel user = UserModel(
        userId: '',
        displayName: '',
        userName: '',
        followers: [],
        following: []);

    return user;
  }
}
