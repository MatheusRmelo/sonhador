import 'package:mobx/mobx.dart';
import 'package:sonhador/app/modules/discovery/model/discovery_text_model.dart';
import 'package:sonhador/app/modules/discovery/model/discovery_user_model.dart';
import 'package:sonhador/app/modules/discovery/repository/discovery_repository.dart';
part 'discovery_controller.g.dart';

class DiscoveryController = _DiscoveryControllerBase with _$DiscoveryController;

abstract class _DiscoveryControllerBase with Store {
  final DiscoveryRepository repository;

  @observable
  ObservableFuture<List<DiscoveryTextModel>> texts;
  @observable
  ObservableFuture<List<DiscoveryUserModel>> users;

  _DiscoveryControllerBase(this.repository) {
    fetchTexts();
  }

  @action
  void fetchTexts() {
    texts = repository.getTopTexts().asObservable();
    users = repository.getTopUsers().asObservable();
  }
}
