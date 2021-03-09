import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:sonhador/app/modules/discovery/model/discovery_text_model.dart';
import 'package:sonhador/app/modules/discovery/model/discovery_user_model.dart';
import 'package:sonhador/app/modules/discovery/repository/discovery_search_repository.dart';
part 'discovery_search_controller.g.dart';

class DiscoverySearchController = _DiscoverySearchControllerBase
    with _$DiscoverySearchController;

abstract class _DiscoverySearchControllerBase with Store {
  final DiscoverySearchRepository repository;

  @observable
  ObservableFuture<List<DiscoveryTextModel>> texts;
  @observable
  ObservableFuture<List<DiscoveryUserModel>> users;

  @observable
  Timer _timer = Timer(Duration(seconds: 1), () {});

  _DiscoverySearchControllerBase(this.repository) {
    texts = repository.searchTexts('').asObservable();
    users = repository.searchUsers('').asObservable();
  }

  @action
  void searchText(String textSearch) {
    textSearch = textSearch.trim().toLowerCase();
    if (_timer.isActive) {
      _timer.cancel();
    }
    _timer = Timer(Duration(seconds: 1), () {
      texts = repository.searchTexts(textSearch).asObservable();
    });
  }

  @action
  void searchUser(String textSearch) {
    textSearch = textSearch.trim().toLowerCase();
    if (_timer.isActive) {
      _timer.cancel();
    }
    _timer = Timer(Duration(seconds: 1), () {
      users = repository.searchUsers(textSearch).asObservable();
    });
  }
}
