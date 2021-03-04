import 'package:mobx/mobx.dart';
import 'package:sonhador/app/modules/profile/model/profile_model.dart';
import 'package:sonhador/app/modules/profile/repository/profile_repository.dart';
part 'profile_controller.g.dart';

class ProfileController = _ProfileControllerBase with _$ProfileController;

abstract class _ProfileControllerBase with Store {
  final ProfileRepository repository;
  @observable
  ObservableFuture<ProfileModel> photoUrl;
  @observable
  bool loading;

  _ProfileControllerBase(this.repository);

  @action
  void getPhoto(String userId) {
    photoUrl = repository.downloadFile(userId).asObservable();
  }
}
