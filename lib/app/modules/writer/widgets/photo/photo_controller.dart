import 'dart:io';

import 'package:mobx/mobx.dart';
import 'package:sonhador/app/modules/writer/model/photo_model.dart';
import 'package:sonhador/app/modules/writer/repository/writer_repository.dart';
import 'package:sonhador/app/modules/writer/writer_controller.dart';
part 'photo_controller.g.dart';

class PhotoController = _PhotoControllerBase with _$PhotoController;

abstract class _PhotoControllerBase with Store {
  final WriterRepository repository;
  final WriterController controller;
  @observable
  ObservableFuture<PhotoModel> photo;

  @observable
  bool loading = false;

  _PhotoControllerBase(this.repository, this.controller) {
    getPhoto(controller.text.value.id);
  }
  @action
  Future<bool> savePhoto(File file, String textId) async {
    await repository.savePhoto(textId, file);
    getPhoto(textId);
    return true;
  }

  @action
  void getPhoto(String textId) {
    photo = repository.getPhoto(textId).asObservable();
    loading = true;
  }

  Future<bool> published(String textId) async {
    return await repository.verifyPublish(textId);
  }
}
