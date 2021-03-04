import 'package:mobx/mobx.dart';
import 'package:sonhador/app/model/user_model.dart';
import 'package:sonhador/app/repository/user_repository.dart';
import 'package:sonhador/app/services/user_services.dart';
part 'app_controller.g.dart';

class AppController = _AppControllerBase with _$AppController;

abstract class _AppControllerBase with Store {
  final UserRepository repository;
  final UserService service;

  @observable
  ObservableFuture<UserModel> user;

  _AppControllerBase(this.repository, this.service) {
    //loginGmail();
  }

  @action
  void verifyLogin() {
    user = service.verifyUser().asObservable();
  }

  @action
  void loginGmail() {
    user = repository.signInWithGoogle().asObservable();
  }

  @action
  void signOut() {
    user = repository.signOutGoogle().asObservable();
    //loginGmail();
  }

  @action
  void setUserName(String userName) {
    user = repository
        .editUserName(user.value.userId, userName, user.value)
        .asObservable();
  }

  @action
  void setDisplayName(String displayName) {
    user = repository
        .editDisplayName(user.value.userId, displayName, user.value)
        .asObservable();
  }

  @action
  void newFollow(String otherId) {
    if (user.value.following.contains(otherId)) {
      user.value.following.remove(otherId);
      repository.newFollow(user.value, otherId);
    } else {
      user.value.following.add(otherId);
      repository.newFollow(user.value, otherId);
    }
  }

  @action
  Future<String> getUserName(String userId) async {
    return await repository.getUserName(userId);
  }
}
