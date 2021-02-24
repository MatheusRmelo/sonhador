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
}
