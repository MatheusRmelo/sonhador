import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:sonhador/app/modules/home/home_content/repository/home_text_repository.dart';
part 'comment_controller.g.dart';

class CommentController = _CommentControllerBase with _$CommentController;

abstract class _CommentControllerBase with Store {
  final HomeTextRepository repository;

  _CommentControllerBase(this.repository);
  @observable
  String comment = '';
  @observable
  TextEditingController textController = TextEditingController(text: '');
}
