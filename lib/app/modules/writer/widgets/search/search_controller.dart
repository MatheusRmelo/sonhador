import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:sonhador/app/app_controller.dart';
import 'package:sonhador/app/modules/writer/repository/writer_repository.dart';
import '../../model/text_model.dart';
part 'search_controller.g.dart';

class SearchController = _SearchControllerBase with _$SearchController;

abstract class _SearchControllerBase with Store {
  final WriterRepository repository;
  final AppController appController;

  @observable
  ObservableFuture<List<TextModel>> texts;
  @observable
  ObservableFuture<List<TextModel>> textsOld;
  @observable
  Timer _timer = Timer(Duration(seconds: 1), () {});

  _SearchControllerBase(this.repository, this.appController) {
    fetchTexts(appController.user.value.userId);
  }

  @action
  void fetchTexts(String userId) {
    texts = repository.getAllTexts(userId).asObservable();
  }

  @action
  void searchText(String textSearch) {
    textSearch = textSearch.trim().toLowerCase();
    if (_timer.isActive) {
      _timer.cancel();
    }
    _timer = Timer(Duration(seconds: 1), () {
      texts = repository
          .searchTexts(appController.user.value.userId, textSearch)
          .asObservable();
    });
  }
}
