import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:sonhador/app/modules/writer/repository/writer_repository.dart';

part 'hashtags_controller.g.dart';

class HashTagsController = _HashTagsControllerBase with _$HashTagsController;

abstract class _HashTagsControllerBase with Store {
  final WriterRepository repository;

  @observable
  TextEditingController textController = TextEditingController(text: '');
  @observable
  String tags;

  _HashTagsControllerBase(this.repository);

  @action
  void saveHashtags(String id) {
    tags = tags.replaceAll('#', '');
    List listTags = tags.split(' ');
    repository.saveHashtags(id, listTags);
  }
}
