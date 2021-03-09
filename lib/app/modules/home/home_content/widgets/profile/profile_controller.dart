import 'package:mobx/mobx.dart';
import 'package:sonhador/app/model/user_model.dart';
import 'package:sonhador/app/modules/profile/model/profile_model.dart';
import 'package:sonhador/app/modules/profile/repository/profile_repository.dart';
import 'package:sonhador/app/repository/user_repository.dart';
part 'profile_controller.g.dart';

class HomeProfileController = _HomeProfileControllerBase
    with _$HomeProfileController;

abstract class _HomeProfileControllerBase with Store {
  final UserRepository userRepository;
  final ProfileRepository profileRepository;

  @observable
  ObservableFuture<UserModel> user;
  @observable
  ObservableFuture<ProfileModel> photoUrl;
  @observable
  bool loading;
  _HomeProfileControllerBase(this.userRepository, this.profileRepository);

  @action
  void getUser(String userId) {
    user = userRepository.getUser(userId).asObservable();
  }

  @action
  void getPhoto(String userId) {
    photoUrl = profileRepository.downloadFile(userId).asObservable();
  }

  @action
  void newFollow(String userId) {
    if (user.value.followers.contains(userId)) {
      user.value.followers.remove(userId);
    } else {
      user.value.followers.add(userId);
    }
    loading = false;
  }

  @action
  void unfollow() {}
}
