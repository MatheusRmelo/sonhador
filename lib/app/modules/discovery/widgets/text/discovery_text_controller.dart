import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:sonhador/app/modules/discovery/repository/discovery_text_repository.dart';
import 'package:sonhador/app/modules/home/home_content/model/home_text_model.dart';

part 'discovery_text_controller.g.dart';

class DiscoveryTextController = _DiscoveryTextControllerBase
    with _$DiscoveryTextController;

abstract class _DiscoveryTextControllerBase with Store {
  final DiscoveryTextRepository repository;

  @observable
  int currentPage = 0;
  @observable
  TextEditingController textController = TextEditingController(text: '');
  @observable
  ObservableFuture<HomeTextModel> text;
  @observable
  ObservableFuture<String> photoUrl;

  _DiscoveryTextControllerBase(this.repository);

  @action
  void fetchText(String textId) {
    text = repository.getText(textId).asObservable();
  }

  @action
  void likedText(String userId) {
    if (text.value.likes.contains(userId)) {
      text.value.likes.remove(userId);
    } else {
      text.value.likes.add(userId);
    }
    repository.likedText(text.value);
    currentPage = currentPage;
  }

  @action
  void saveComment(String userId, String comment, String userName) {
    text.value.comments.add({
      "user_id": userId,
      "comment": comment,
      "likes": [],
      "user_name": userName
    });
    repository.saveComment(text.value);
    currentPage = currentPage;
  }

  @action
  void likedComment(String userId, int index) {
    if (text.value.comments[index]['likes'].contains(userId)) {
      text.value.comments[index]['likes'].remove(userId);
    } else {
      text.value.comments[index]['likes'].add(userId);
    }
    repository.likedComment(text.value);
    currentPage = currentPage;
  }
}
