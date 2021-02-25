import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:sonhador/app/modules/home/home_content/repository/home_text_repository.dart';

import 'model/home_text_model.dart';
part 'home_content_controller.g.dart';

class HomeContentController = _HomeContentControllerBase
    with _$HomeContentController;

abstract class _HomeContentControllerBase with Store {
  final HomeTextRepository repository;

  @observable
  int currentPage = 0;
  @observable
  int currentText = 0;
  @observable
  TextEditingController textController = TextEditingController(text: '');
  @observable
  ObservableFuture<List<HomeTextModel>> texts;

  _HomeContentControllerBase(this.repository) {
    fetchTexts();
  }

  @action
  void fetchTexts() {
    texts = repository.getTexts().asObservable();
  }

  @action
  void likedText(String userName) {
    if (texts.value[currentText].likes.contains(userName)) {
      texts.value[currentText].likes.remove(userName);
    } else {
      texts.value[currentText].likes.add(userName);
    }
    repository.likedText(texts.value[currentText]);
    currentText = currentText;
  }
}
