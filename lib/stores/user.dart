import 'package:mobx/mobx.dart';

import '../models/user.dart';

part 'user.g.dart';

class User = _User with _$User;

abstract class _User with Store {
  @observable
  String id;
  @observable
  String userName;
  @observable
  String name;
  @observable
  String email;

  String getId() => id;
  setId(String value) => id = value;

  loginGmail() {
    var user = signInWithGoogle().then((value) => value);
    print(user);
  }
}
