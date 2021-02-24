import 'package:shared_preferences/shared_preferences.dart';
import 'package:sonhador/app/model/user_model.dart';

class UserService {
  Future<UserModel> verifyUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString('user_name');
    String displayName = prefs.getString('display_name');
    String userId = prefs.getString('user_id');

    if (userId == null) {
      userId = '';
      userName = '';
      displayName = '';
    }

    UserModel user = UserModel(userId, displayName, userName);

    return user;
  }

  void saveUser(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('user_name', user.userName);
    await prefs.setString('display_name', user.displayName);
    await prefs.setString('user_id', user.userId);
  }

  Future<UserModel> clearUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', '');
    await prefs.setString('display_name', '');
    await prefs.setString('user_id', '');

    UserModel user = UserModel('', '', '');

    return user;
  }
}
