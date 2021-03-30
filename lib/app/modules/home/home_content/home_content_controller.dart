import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:sonhador/app/modules/home/home_content/repository/home_text_repository.dart';
import 'package:sonhador/app/modules/home/home_content/repository/points_repository.dart';

import 'model/home_text_model.dart';
part 'home_content_controller.g.dart';

class HomeContentController = _HomeContentControllerBase
    with _$HomeContentController;

abstract class _HomeContentControllerBase with Store {
  final HomeTextRepository repository;
  final PointsRepository pointsRepository;

  @observable
  int currentPage = 0;
  @observable
  int currentText = 0;
  @observable
  TextEditingController textController = TextEditingController(text: '');
  @observable
  ObservableFuture<List<HomeTextModel>> texts;
  @observable
  ObservableFuture<String> photoUrl;
  @observable
  ObservableFuture<List<HomeTextModel>> nextTexts;

  _HomeContentControllerBase(this.repository, this.pointsRepository) {
    fetchTexts();
  }

  @action
  void fetchTexts() {
    texts = repository.getTexts().asObservable();
  }

  @action
  void fetchMoreTexts(String lastId) {
    nextTexts = repository.getMoreTexts(lastId).asObservable();
  }

  @action
  void fetchFollowTexts(String lastId, String userId) {
    texts = repository.getFollowTexts(lastId, userId).asObservable();
  }

  @action
  void getMoreTexts() {
    if (nextTexts != null && nextTexts.value != null) {
      for (HomeTextModel text in nextTexts.value) {
        texts.value.add(text);
      }
      // print(currentText);
      currentPage = 0;
      nextTexts = null;
    }
  }

  @action
  void likedText(String userId) {
    if (texts.value[currentText].likes.contains(userId)) {
      texts.value[currentText].likes.remove(userId);
      pointsRepository.score('like', texts.value[currentText].id,
          texts.value[currentText].userId, false);
    } else {
      texts.value[currentText].likes.add(userId);
      pointsRepository.score('like', texts.value[currentText].id,
          texts.value[currentText].userId, true);
    }
    repository.likedText(texts.value[currentText]);
    currentPage = currentPage;
  }

  @action
  void saveComment(String userId, String comment, String userName) {
    texts.value[currentText].comments.add({
      "user_id": userId,
      "comment": comment,
      "likes": [],
      "user_name": userName
    });
    repository.saveComment(texts.value[currentText]);
    pointsRepository.score('comment', texts.value[currentText].id,
        texts.value[currentText].userId, true);
  }

  @action
  void likedComment(String userId, int index) {
    if (texts.value[currentText].comments[index]['likes'].contains(userId)) {
      texts.value[currentText].comments[index]['likes'].remove(userId);
    } else {
      texts.value[currentText].comments[index]['likes'].add(userId);
    }
    repository.likedComment(texts.value[currentText]);
    currentPage = currentPage;
  }

  @action
  void sharedText(String userId) {
    if (!texts.value[currentText].shared.contains(userId)) {
      texts.value[currentText].shared.add(userId);
      pointsRepository.score('share', texts.value[currentText].id,
          texts.value[currentText].userId, true);
      repository.sharedText(texts.value[currentText]);
      currentPage = currentPage;
    }
  }
}
