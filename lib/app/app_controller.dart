import 'package:mobx/mobx.dart';
import 'package:sonhador/app/model/user_model.dart';
import 'package:sonhador/app/repository/user_repository.dart';
part 'app_controller.g.dart';

class AppController = _AppControllerBase with _$AppController;

abstract class _AppControllerBase with Store {
  final UserRepository repository;
  @observable
  ObservableFuture<UserModel> user;

  _AppControllerBase(this.repository) {
    loginGmail();
  }

  @action
  void loginGmail() {
    user = repository.signInWithGoogle().asObservable();
  }

  @action
  void signOut() {
    repository.signOutGoogle();
    loginGmail();
  }
}
