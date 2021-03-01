import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'edit_controller.g.dart';

class EditController = _EditControllerBase with _$EditController;

abstract class _EditControllerBase with Store {
  @observable
  TextEditingController userNameController = TextEditingController(text: '');
  @observable
  TextEditingController userDisplayController = TextEditingController(text: '');
}
